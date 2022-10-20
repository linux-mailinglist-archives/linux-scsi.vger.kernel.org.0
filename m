Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FFC60709F
	for <lists+linux-scsi@lfdr.de>; Fri, 21 Oct 2022 08:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiJUG7S convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-scsi@lfdr.de>); Fri, 21 Oct 2022 02:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiJUG7Q (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 21 Oct 2022 02:59:16 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A001A244708
        for <linux-scsi@vger.kernel.org>; Thu, 20 Oct 2022 23:59:15 -0700 (PDT)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEJsWRWlGSWpSXmKPExsWyc0WAsq65c1C
  yweutTBbrFhxnt3j0uJ3RYmb3FzaLDbutLd5+8bHYcrGV0aLr2xUmi4a9zBavv5ZaLNuwjdVi
  wtteJosLZ7awWUw5uZ/dYt+jK6wWs+c+YLL49mk5k8WnWyeYLbqv72CzaLhpYNF76j+Lg4jH9
  5cr2TyWXT7H6PGrbS6zx6SHfh6r5mxg9dg56y67R9s0M4/Fe14yeVy9fYPdY+3te6welzq1PK
  Yf38/isebPB1aPn3cmMnlMPXCOxePU8jnsAUJRrJl5SfkVCawZR7f0sBasZ6r4d+EScwNjA1M
  XIyeHkECJxLNXnxhBbF4BO4nJV/rBbGYBPYkbU6ewQcQFJU7OfMICEdeWWLbwNXMXIweQrSbx
  tasEJCwsYCLx9+5OVpCwiICKxJsd3CBhNqAp+1s+s4PYLAKqEpPXTmOD2CojcXlRI9sERu5ZS
  JbNQrJsFpJlsxCWLWBkWcVoWpxaVJZapGuol1SUmZ5RkpuYmaOXWKWbqJdaqlueWlyia6SXWF
  6sl1pcrFdcmZuck6KXl1qyiREYlSnFqod2ML5a8kfvEKMkB5OSKK+QQlCyEF9SfkplRmJxRnx
  RaU5q8SFGPQ4OgQtnH35iFLjy4VMTkxRLXn5eqpIE7xRHoGrBotT01Iq0zBxgEoFpkODgURLh
  fecAlOYtLkjMLc5Mh0idYszn2L5z/15mjt3HzwPJJd8vAsl/H68AyQcHrgHJqbP/7QeKg8nlY
  HIVmJz5te0AM8fXbV1A8vSf6QeYhcCukBLnrQS5QgBkTUZpHtwRsKR6iVFWSpiXkYGBQYinIL
  UoN7MEVf4VozgHo5IwrxfIFJ7MvBK4W18BvcEE9IbpFj+QN0oSEVJSDUyVmzwP8ke7uHYcXt6
  sx3vS8cwtjkxVu4tPTD6IfHSPk2MTe3bpWUvB18i7DZmMyqouq3LDRI8sd2zf1eQeOG/T7Iqe
  14fdi+bd3/rytd35M8cbFJ6z/1iflsazbFIch2Lsj4p5zL269ZbRCZd2aTtZebdqFn+aVDK3h
  O3u7w3bwxpXJqXM6X6fXuZs/6vNM/TuBQmR/utP33f6Xb7HW/v/dWvntA+vOVdt5trU7fmy+M
  fXY7ocpasbi0r6XZYdM5zPvdxapm5KvC/fx9uOfTxZy81+8W85EFO03Xbalo99s5+59T+69/W
  nUgzTwTNTN5Z8WdRatf/kCZtdG7Rv/I+L3LNfPflevc/CHRMyt85VYinOSDTUYi4qTgQAEErw
  2CUEAAA=
X-Env-Sender: tianasime@gmail.com
X-Msg-Ref: server-18.tower-539.messagelabs.com!1666335542!213759!1
X-Originating-IP: [185.168.80.35]
X-SYMC-ESS-Client-Auth: outbound-route-from=fail
X-StarScan-Received: 
X-StarScan-Version: 9.100.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 10160 invoked from network); 21 Oct 2022 06:59:03 -0000
Received: from unknown (HELO VSRVDCF1106) (185.168.80.35)
  by server-18.tower-539.messagelabs.com with SMTP; 21 Oct 2022 06:59:03 -0000
Received: from [194.99.45.27] (Unknown [194.99.45.27])
        by VSRVDCF1106 with ESMTP
        ; Thu, 20 Oct 2022 17:03:05 +0200
Message-ID: <1B8C30BD-C6AB-4BF4-A969-B3B8FF5CC8E2@VSRVDCF1106>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Description: Mail message body
Subject: RE; Dear Customer we are still waiting!!!!!
To:     Recipients <tianasime@gmail.com>
From:   Mrs Sonia Anderson <tianasime@gmail.com>
Date:   Thu, 20 Oct 2022 08:03:03 -0700
Reply-To: bo979685@gmail.com
X-Spam-Status: Yes, score=7.3 required=5.0 tests=BAYES_50,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SBL,SPF_HELO_NONE,SPF_SOFTFAIL,
        SPOOFED_FREEM_REPTO,T_HK_NAME_FM_MR_MRS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [tianasime[at]gmail.com]
        *  0.1 RCVD_IN_SBL RBL: Received via a relay in Spamhaus SBL
        *      [194.99.45.27 listed in zen.spamhaus.org]
        * -0.0 RCVD_IN_MSPIKE_H2 RBL: Average reputation (+2)
        *      [195.245.231.3 listed in wl.mailspike.net]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [195.245.231.3 listed in list.dnswl.org]
        *  0.7 SPF_SOFTFAIL SPF: sender does not match SPF record (softfail)
        *  0.0 DKIM_ADSP_CUSTOM_MED No valid author signature, adsp_override
        *      is CUSTOM_MED
        *  1.0 FORGED_GMAIL_RCVD 'From' gmail.com does not match 'Received'
        *      headers
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [bo979685[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.9 NML_ADSP_CUSTOM_MED ADSP custom_med hit, and not from a mailing
        *       list
        *  2.5 SPOOFED_FREEM_REPTO Forged freemail sender with freemail
        *      reply-to
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Bank of America
Charlotte, North Carolina, United States
North Tryon Street, Charlotte, NC 28255
Text/Fax: Ext-8-1-0880.050.640
email;bo979685@gmail.com

Dear Customer,

We are still waiting for your reply to our last email which was sent to you .

Thanks,
Sonia Anderson
Financial Inquiries Unit 

