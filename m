Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F6E3ADF2D
	for <lists+linux-scsi@lfdr.de>; Sun, 20 Jun 2021 17:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbhFTPZf (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 20 Jun 2021 11:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbhFTPZf (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 20 Jun 2021 11:25:35 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A2DC061574
        for <linux-scsi@vger.kernel.org>; Sun, 20 Jun 2021 08:23:21 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id f10so5062117plg.0
        for <linux-scsi@vger.kernel.org>; Sun, 20 Jun 2021 08:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:mime-version:content-transfer-encoding:to
         :subject;
        bh=ypAl3lmrI5jukQJOrNpPkY/LSGAqKfZDGORc31mb7QQ=;
        b=UYiv6YohVnYYn8HBUjZWoiAmicL7TnpWUgHTl64UAJyVFDIxpokE9yUkFgAvOQNIf1
         5v4i2XTE5iJ6lh4UvWe3cgXvsEm04XEEtUI5eIGQ4QSknYIfqhKl19IsGjQ4+rwTMaSj
         6Fp9Iixf2RReTXLAzMDbgfFae1RVKag8Kf2908wE/MX6tMhkyXws9ZsH3SmuK1iMKk5x
         23K5zpMGDHvwuqAYIc4pugSZQSEhKTDntF3C+oKHcVIeWrFjf33b2Ix2SICiqPKplPat
         tMivzFNezzE+rffpLNQ4am0zEpLHj8E/YiWyprfLU6NLgNjzOGzWNHn9JBpTNuQkJ4/V
         X6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:mime-version
         :content-transfer-encoding:to:subject;
        bh=ypAl3lmrI5jukQJOrNpPkY/LSGAqKfZDGORc31mb7QQ=;
        b=uVxVxbExIcRVDpRUIxOInzNMPwTrbVs0xfB4cZIOpFN8IYEUE7+p1ktjweZeTROLLv
         IV4WwhZIed+oOZcxuMiFKVBHJOmFVz4iOX5ZCGytt4N9HivqQ+hu8B29PUDFf3lrWJ90
         +ffnyPCofdWWnu7zRtPQyu5KRt80VnGZH7BKuTVTWNQUmS3HK70te1SArSrT/8b9zkhT
         +IvEqxvc2H4c/ZJaL1XM2S3A8JS3/Yz/2dIMysffEdt5cM5a42y6mEJYStA8E+suSGpl
         LBA+t9xaz5nkjLxHBDEzXC4LC+HYIwlUVJOhAk/YEqgsmUaxGsGaNkZ8ySDusqADyaWt
         MNmw==
X-Gm-Message-State: AOAM5332by7S3Nvv7yvvC0uXO6eZSCT+X9NxT/zxAxQKc3sPlGAVtw1I
        huiW/CdcQA1PFOt+6jhBE4DH1j6TGkE=
X-Google-Smtp-Source: ABdhPJzhEDJRMopLonJHnArC3spKoZMNe2XFTtZlUpveuRYxqGQOZzdMWjEZxCZ3ihYXD+C8w6My3A==
X-Received: by 2002:a17:902:263:b029:110:e758:2748 with SMTP id 90-20020a1709020263b0290110e7582748mr13637215plc.53.1624202601064;
        Sun, 20 Jun 2021 08:23:21 -0700 (PDT)
Received: from [192.168.170.55] ([47.56.132.27])
        by smtp.gmail.com with ESMTPSA id gi20sm6822080pjb.20.2021.06.20.08.23.20
        for <linux-scsi@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Jun 2021 08:23:20 -0700 (PDT)
Message-ID: <60cf5d68.1c69fb81.6154e.19da@mx.google.com>
Date:   Sun, 20 Jun 2021 08:23:20 -0700 (PDT)
From:   "=?utf-8?q?ellen?=" <laurenmitc73@gmail.com>
X-Google-Original-From: =?utf-8?q?ellen?=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
To:     =?utf-8?q?linux-scsi=40vger=2Ekernel=2Eorg?=@vger.kernel.org
Subject: =?utf-8?q?Blog_Collaboration?=
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

SGksIAoKTGlrZSB5b3VyIGJsb2cgdmVyeSBtdWNoIQoKV2UgYXJlIFNQT1RPLCAgYW4gb3V0c3Rh
bmRpbmcgSVQgQ2VydGlmaWNhdGlvbiBPbmxpbmUgVHJhaW5pbmcgd2l0aCAxOCBZZWFycyBPZiBF
ZHVjYXRpb25hbCBFeHBlcmllbmNlLiBIZXJlIElzIE91ciBTaXRlOiBjY2llZHVtcCpzcG90bypu
ZXQKClNpbmNlcmVseSBpbnZpdGUgeW91IHRvIGNvb3BlcmF0ZSB3aXRoIHVzIGZvciBhIHBvc3Qu
CipZb3Ugd3JpdGUgYSAzMDAtNTAwIHdvcmRzIGFydGljbGUgYmFzZWQgb24ga2V5d29yZHMgd2l0
aCBkby1mb2xsb3cgbGlua3MgcHJvdmlkZWQgYnkgdXMgYW5kIHBvc3QgaXQgb24geW91ciBibG9n
IG9yIHNvY2lhbCB3ZWJzaXRlKEZhY2Vib29rLCBJbnN0YWdyYW0sIFlvdVR1YmUsIGV0YyksIHdl
J2xsIHBheSBmb3IgaXQhCgpXYWl0aW5nIGZvciB5b3VyIHBvc2l0aXZlIHJlcGx5LgoKQmVzdCBS
ZWdhcmRzIQ==
