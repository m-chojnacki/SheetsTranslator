VERSION=0.5

.PHONY: all clean

all: SheetsTranslatorBinary.artifactbundle.zip

clean:
	rm -rf .build
	rm -rf SheetsTranslatorBinary.artifactbundle
	rm -rf SheetsTranslatorBinary.artifactbundle.zip

.build/arm64-apple-macosx/release/sheets:
	swift build --product sheets --configuration release --arch arm64

.build/x86_64-apple-macosx/release/sheets:
	swift build --product sheets --configuration release --arch x86_64

SheetsTranslatorBinary.artifactbundle/LICENSE: LICENSE
	mkdir -p SheetsTranslatorBinary.artifactbundle
	cp LICENSE SheetsTranslatorBinary.artifactbundle/

SheetsTranslatorBinary.artifactbundle/info.json: info.json.template
	mkdir -p SheetsTranslatorBinary.artifactbundle
	sed 's/__VERSION__/$(VERSION)/g' info.json.template > SheetsTranslatorBinary.artifactbundle/info.json

SheetsTranslatorBinary.artifactbundle/sheets-$(VERSION)-macos/bin/sheets: .build/arm64-apple-macosx/release/sheets .build/x86_64-apple-macosx/release/sheets
	mkdir -p SheetsTranslatorBinary.artifactbundle/sheets-$(VERSION)-macos/bin
	lipo -create -output $@ $^

SheetsTranslatorBinary.artifactbundle: SheetsTranslatorBinary.artifactbundle/LICENSE SheetsTranslatorBinary.artifactbundle/info.json SheetsTranslatorBinary.artifactbundle/sheets-$(VERSION)-macos/bin/sheets

SheetsTranslatorBinary.artifactbundle.zip: SheetsTranslatorBinary.artifactbundle
	zip -r SheetsTranslatorBinary.artifactbundle.zip SheetsTranslatorBinary.artifactbundle
