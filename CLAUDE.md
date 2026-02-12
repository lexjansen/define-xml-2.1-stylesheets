# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Define-XML v2.1 stylesheets for transforming CDISC Define-XML documents into human-readable HTML format. The project includes two versions:

- **cdisc-2019**: Original CDISC published stylesheet (May 2019)
- **localization**: Enhanced version with internationalization support (English, Chinese, Japanese)

## Running Tests

The main test suite transforms test Define-XML documents to HTML using Saxon HE 12.9 XSLT processor:

```cmd
cd test
transform_definexml.cmd
```

This script:

- Transforms test XML files in `test/xml/` to HTML in `test/html/`
- Tests multiple language variants (en, ja, zh)
- Tests various parameter combinations (with/without parameters table)
- Tests issue-specific cases (issue09, issue15)
- Outputs logs to `transform_definexml.log`

## Transformation Scripts

### Using PowerShell (Windows native)

```powershell
# Basic transformation
.\scripts\xml2html.ps1 localization\define2-1.xsl test\xml\definev21-adam.xml output.html

# With language parameter
.\scripts\xml2html.ps1 localization\define2-1.xsl test\xml\definev21-adam.xml output.html ja
```

### Using Saxon directly

```cmd
java -cp lib\SaxonHE12-9J\saxon-he-12.9.jar net.sf.saxon.Transform ^
  -s:test\xml\definev21-adam.xml ^
  -xsl:localization\define2-1.xsl ^
  -o:output.html ^
  interfaceLang=ja ^
  nCodeListItemDisplay=5 ^
  displayMethodsTable=1
```

## Architecture

### Stylesheets

**localization/define2-1.xsl** (4833 lines)

- Main localized stylesheet supporting XSLT 1.0
- Loads translations from `localization/dictionary.xml`
- Supports Define-XML 2.1 specification including Analysis Results Metadata v1.0 extension
- Generates HTML 4.01 Strict output

**cdisc-2019/stylesheets/define2-1.xsl** (4305 lines)

- Original CDISC stylesheet without localization
- Otherwise similar functionality to localization version

### Key XSLT Parameters

| Parameter | Default | Description |
| ----------- | --------- | ------------- |
| `interfaceLang` | `en` | UI language: en, ja, zh (localization stylesheet only) |
| `nCodeListItemDisplay` | `5` | Number of codelist items in Controlled Terms column (999=all, 0=none) |
| `nCheckValueDisplay` | `5` | Max CheckValue decodes in WhereClause to show Decode values (999=all, 0=none) |
| `displayMethodsTable` | `1` | Display Methods table (0/1) |
| `displayCommentsTable` | `0` | Display Comments table (0/1) |
| `displayPrefix` | `0` | Show prefixes like [Comment], [Method], [Origin] (0/1) |
| `displayLengthDFormatSD` | `0` | Show Length, DisplayFormat, SignificantDigits (0/1) |

### Translation System

`localization/dictionary.xml` contains UI term translations structured as:

```xml
<entry term="English Term">
  <TranslatedText xml:lang="zh">Chinese translation</TranslatedText>
  <TranslatedText xml:lang="ja">Japanese translation</TranslatedText>
</entry>
```

The stylesheet loads this dictionary using `document()` function and looks up terms based on `interfaceLang` parameter.

### Test Structure

```structure
test/
  xml/                    # Input Define-XML documents
    definev21-adam.xml
    definev21-sdtm.xml
    definev21-adam_issue09.xml
    definev21-adam_issue15.xml
  html/                   # Expected HTML outputs
    definev21-adam_ja.html
    definev21-adam_zh.html
    definev21-adam_en.html
    issue09/
    issue15/
  transform_definexml.cmd # Main test script
```

## Recent Features

### Issue #15: WhereClause Decodes (Feb 2026)

Added `nCheckValueDisplay` parameter to control when decode values are displayed in the "Where Condition" column. When a WhereClauseDef has more than `nCheckValueDisplay` CheckValue elements, decodes are not shown (only codes). This prevents cluttered displays when there are many where clause values.

### Issue #9: VLM WhereClause Support (Feb 2023)

Enhanced stylesheet to display decodes in WhereClause even when variables have their codelist defined in Value Level Metadata (VLM) rather than at the variable level.

## Development Notes

- This is an XSLT 1.0 project (not 2.0 or 3.0)
- Saxon HE 12.9 is the XSLT processor (lib/SaxonHE12-9J/)
- Always test both ADaM and SDTM Define-XML documents
- Test with all three languages (en, ja, zh) for localization changes
- HTML output targets HTML 4.01 Strict DTD
- When modifying dictionary.xml, ensure all three languages are provided for new terms
