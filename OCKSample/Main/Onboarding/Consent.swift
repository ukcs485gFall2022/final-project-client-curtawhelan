//
//  Consent.swift
//  OCKSample
//
//  Created by Corey Baker on 11/11/22.
//  Copyright © 2022 Network Reconnaissance Lab. All rights reserved.
//

import Foundation

// swiftlint:disable line_length

/*
 xTODO: The informedConsentHTML property allows you to display HTML
 on an ResearchKit Survey. Modify the consent so it properly
 represents the usecase of your application.
 */

let informedConsentHTML = """
    <!DOCTYPE html>
    <html lang="en" xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta name="viewport" content="width=400, user-scalable=no">
        <meta charset="utf-8" />
        <style type="text/css">
            ul, p, h1, h3 {
                text-align: left;
            }
        </style>
    </head>
    <body>
        <h1>Informed Consent</h1>
        <h3>What you can expect</h3>
        <ul>
            <li>You will be asked to complete various tasks such as surveys as well as tasks that you make yourself.</li>
            <li>Trek Track can send you notifications to remind you to complete these tasks.</li>
            <li>You will be asked to share various health data types to help visualize and track your progress.</li>
            <li>Your information will be kept private, secure and will never be sold to advertisers.</li>
            <li>This app will only work as well as you let it, holding yourself accountable is key.</li>
        </ul>
        <p>By signing below, I acknowledge that I have read this consent carefully, I understand all of its terms, I am beginning my Trek and consent to my Trek being Tracked voluntarily. I understand that my information will only be used and disclosed for the purposes described in the consent.</p>
        <p>Please sign using your finger below.</p>
        <br>
    </body>
    </html>
    """
