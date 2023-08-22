Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62B4784E57
	for <lists+linux-scsi@lfdr.de>; Wed, 23 Aug 2023 03:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjHWBn0 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 22 Aug 2023 21:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbjHWBnY (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 22 Aug 2023 21:43:24 -0400
X-Greylist: delayed 917 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Aug 2023 18:43:22 PDT
Received: from symantec4.comsats.net.pk (symantec4.comsats.net.pk [203.124.41.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60089E4B
        for <linux-scsi@vger.kernel.org>; Tue, 22 Aug 2023 18:43:22 -0700 (PDT)
X-AuditID: cb7c291e-055ff70000002aeb-4c-64e54bbc0cfb
Received: from iesco.comsatshosting.com (iesco.comsatshosting.com [210.56.28.11])
        (using TLS with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by symantec4.comsats.net.pk (Symantec Messaging Gateway) with SMTP id AA.FB.10987.CBB45E46; Wed, 23 Aug 2023 04:58:52 +0500 (PKT)
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns;
        d=iesco.com.pk; s=default;
        h=received:content-type:mime-version:content-transfer-encoding
          :content-description:subject:to:from:date:reply-to;
        b=OsGDCA0jUmfFV416pfSvOEHyj+x1RHWpx4TZ9wJyaamdXA0DNCOBi7Lzsiz5mKgc2
          312etZme+5rFJAHH01pugaJFFD6YsKe0AB/xRRwrwj9b8qDuVVXFPnQOyFbLOBsSl
          +wd7qT7ytD0RiR9fIl7C7MVQ4540d4N4Ih8oxSlA4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iesco.com.pk; s=default;
        h=reply-to:date:from:to:subject:content-description
          :content-transfer-encoding:mime-version:content-type;
        bh=GMzYzcyTxDsE6wX/XHG6MHqAdAiHrhqbmmLQ/TZ1QnQ=;
        b=c5lowGFTesFUnA7k6H+UJi9vX3NpsvZkAxrKVg6QwS0CWmP3Xonwu0/yx62AtQuyv
          I12dpGwBErhWsuKZRWHTyhPF9dUvi0POhaYOUSGtz9qhSqBvS8bfBiogspcBwvb/b
          OlGdfYUTX8rwFbhJTs46eu08arLIwjAwZbG5PUAG4=
Received: from [94.156.6.90] (UnknownHost [94.156.6.90]) by iesco.comsatshosting.com with SMTP;
   Wed, 23 Aug 2023 04:31:07 +0500
Message-ID: <AA.FB.10987.CBB45E46@symantec4.comsats.net.pk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Re; Interest,
To:     linux-scsi@vger.kernel.org
From:   "Chen Yun" <pso.chairmanbod@iesco.com.pk>
Date:   Tue, 22 Aug 2023 16:31:21 -0700
Reply-To: chnyne@gmail.com
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDLMWRmVeSWpSXmKPExsVyyUKGW3eP99MUg83H5Sy6r+9gc2D0+LxJ
        LoAxissmJTUnsyy1SN8ugStjyboLLAW7mSva+hexNDA+Zupi5OSQEDCReDrvF2sXIxeHkMAe
        Joknh/YygzgsAquZJVas3cYG4Txklrjz+wkrSIuQQDOjxKEjmiA2r4C1xOe7ZxlBbGYBPYkb
        U6ewQcQFJU7OfMICEdeWWLbwNdBUDiBbTeJrVwlIWFhATOLTtGXsILaIgJzE5uVfwcrZBPQl
        VnxtBhvJIqAqMWPpJHaItVISG6+sZ5vAyD8LybZZSLbNQrJtFsK2BYwsqxgliitzE4Ghlmyi
        l5yfW5xYUqyXl1qiV5C9iREYhqdrNOV2MC69lHiIUYCDUYmH9+e6JylCrIllQF2HGCU4mJVE
        eKW/P0wR4k1JrKxKLcqPLyrNSS0+xCjNwaIkzmsr9CxZSCA9sSQ1OzW1ILUIJsvEwSnVwCgQ
        qq/evVBfcOGcIufvB34WzbC+eqBvY8j1uddX7Xvw5+M+hd32d9bWWW1ZcqZfwOqixfa8XJeJ
        a29tSRAx3X1zwbzcuqfLfTNnaG27H/Dw758FK9k/PQ/3XGj6lOPqN/FFfvlpG/r2WJWfvGb+
        LySjoE9Es7aaeapGS5X2T7VDdyuZDvtfW+qmxFKckWioxVxUnAgAhqan/j8CAAA=
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        RCVD_IN_DNSWL_LOW,RCVD_IN_SBL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: iesco.com.pk]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [94.156.6.90 listed in zen.spamhaus.org]
        *  0.1 RCVD_IN_SBL RBL: Received via a relay in Spamhaus SBL
        * -0.7 RCVD_IN_DNSWL_LOW RBL: Sender listed at https://www.dnswl.org/,
        *       low trust
        *      [203.124.41.30 listed in list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Re; Interest,

I am interested in discussing the Investment proposal as I explained
in my previous mail. May you let me know your interest and the
possibility of a cooperation aimed for mutual interest.

Looking forward to your mail for further discussion.

Regards

------
Chen Yun - Chairman of CREC
China Railway Engineering Corporation - CRECG
China Railway Plaza, No.69 Fuxing Road, Haidian District, Beijing, P.R.
China

