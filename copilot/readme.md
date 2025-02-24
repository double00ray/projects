# Simple Adaptive Card

## Summary

This repository contains a basic Adaptive Card JSON configuration. The card is designed to collect user information in a structured manner. It includes sections for name, address, and contact details. The card uses nested `Action.ShowCard` actions to progressively reveal input fields for the user to fill out.

## Features

- **Adaptive Card Version:** 1.3
- **Sections:**
  - Name (First Name, Middle Name, Last Name)
  - Address (Address Line 1, Address Line 2, City, State, Zip Code)
  - Contact Information (Cell Number, Home Number, Email Address)
- **Validation:**
  - First Name and Last Name are required fields with error messages.
- **Actions:**
  - Nested `Action.ShowCard` actions to reveal subsequent sections.
  - Final `Action.Submit` to submit the collected information.

## Usage

To use this Adaptive Card, you can copy the JSON configuration from the `simple_card.json` file and use it in any platform that supports Adaptive Cards, such as Microsoft Teams, Bot Framework, or other supported applications.

## JSON Schema

The JSON schema for the Adaptive Card is available at [Adaptive Cards Schema](http://adaptivecards.io/schemas/adaptive-card.json).

## Example

Here is an example of how the card looks:

```json
{
    "type": "AdaptiveCard",
    "version": "1.3",
    "body": [
        {
            "type": "TextBlock",
            "text": "Please provide the following information:",
            "wrap": true,
            "style": "heading"
        }
    ],
    "$schema": "http://adaptivecards.io/schemas/adaptive-card.json",
    "actions": [
        {
            "type": "Action.ShowCard",
            "title": "1. Name",
            "card": {
                "version": "1.3",
                "type": "AdaptiveCard",
                "$schema": "http://adaptivecards.io/schemas/adaptive-card.json",
                "body": [
                    {
                        "type": "Container",
                        "id": "nameProperties",
                        "items": [
                            {
                                "type": "Input.Text",
                                "label": "First Name",
                                "id": "FirstName",
                                "isRequired": true,
                                "errorMessage": "First Name is required"
                            },
                            {
                                "type": "Input.Text",
                                "label": "Middle Name",
                                "id": "MiddleName"
                            },
                            {
                                "type": "Input.Text",
                                "label": "Last Name",
                                "id": "LastName",
                                "isRequired": true,
                                "errorMessage": "Last Name is required"
                            }
                        ]
                    }
                ],
                "actions": [
                    {
                        "type": "Action.ShowCard",
                        "title": "2. Address",
                        "card": {
                            "version": "1.3",
                            "type": "AdaptiveCard",
                            "$schema": "http://adaptivecards.io/schemas/adaptive-card.json",
                            "body": [
                                {
                                    "type": "Container",
                                    "id": "addressProperties",
                                    "items": [
                                        {
                                            "type": "Input.Text",
                                            "label": "Address line 1",
                                            "id": "AddressLine1"
                                        },
                                        {
                                            "type": "Input.Text",
                                            "label": "Address line 2",
                                            "id": "AddressLine2"
                                        },
                                        {
                                            "type": "ColumnSet",
                                            "columns": [
                                                {
                                                    "type": "Column",
                                                    "width": "stretch",
                                                    "items": [
                                                        {
                                                            "type": "Input.Text",
                                                            "label": "City",
                                                            "id": "City"
                                                        }
                                                    ]
                                                },
                                                {
                                                    "type": "Column",
                                                    "width": "stretch",
                                                    "items": [
                                                        {
                                                            "type": "Input.Text",
                                                            "label": "State",
                                                            "id": "State"
                                                        }
                                                    ]
                                                },
                                                {
                                                    "type": "Column",
                                                    "width": "stretch",
                                                    "items": [
                                                        {
                                                            "type": "Input.Text",
                                                            "label": "Zip Code",
                                                            "id": "Zip"
                                                        }
                                                    ]
                                                }
                                            ]
                                        }
                                    ]
                                }
                            ],
                            "actions": [
                                {
                                    "type": "Action.ShowCard",
                                    "title": "3. Phone/Email",
                                    "card": {
                                        "version": "1.3",
                                        "type": "AdaptiveCard",
                                        "$schema": "http://adaptivecards.io/schemas/adaptive-card.json",
                                        "body": [
                                            {
                                                "type": "Input.Text",
                                                "label": "Cell Number",
                                                "id": "CellPhone"
                                            },
                                            {
                                                "type": "Input.Text",
                                                "label": "Home Number",
                                                "id": "HomePhone"
                                            },
                                            {
                                                "type": "Input.Text",
                                                "label": "Email Address",
                                                "id": "Email"
                                            }
                                        ],
                                        "actions": [
                                            {
                                                "type": "Action.Submit",
                                                "title": "Submit"
                                            }
                                        ]
                                    }
                                }
                            ]
                        }
                    }
                ]
            }
        }
    ]
}