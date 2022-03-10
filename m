Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041394D3E59
	for <lists+linux-scsi@lfdr.de>; Thu, 10 Mar 2022 01:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239041AbiCJAqc (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 9 Mar 2022 19:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235400AbiCJAqa (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 9 Mar 2022 19:46:30 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B8612553C
        for <linux-scsi@vger.kernel.org>; Wed,  9 Mar 2022 16:45:30 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id g17so6748367lfh.2
        for <linux-scsi@vger.kernel.org>; Wed, 09 Mar 2022 16:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=fNxQZUenjMYTRaLZ8bVRtrts/KBsq8qlTn4csxEcmJM=;
        b=JpqJAam0V1WCNOVR9o2XNkqGZcWaPC5UAXsqxiV8txSV25UqVNAHUYoHuTMlsQV+hU
         FF7ZuXifjYmr44etBmQHXLCw+/cFUAfvzYsKow3QIjCesbLf8Jo2DHMfbxDYKtGsJ6S7
         2nequQI8coXQnKFBkLJ9PuIOgpwAYmQr0SUVYXmMCNMm1EGVOTlpXBO53KQotzn6Ys1m
         JcMlH3rS+aChYHjhhRVym8LzSPaWUikv8yW7QcAFpQQMIP4cNkNiY2xXCNwU37LkTy5b
         RJp0RoRyimNnORIKutG5x6wYz2SshaCw8UzAiz7r0IDqm5DklrpvUX4SvbWwlHEvWHqC
         +Lpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=fNxQZUenjMYTRaLZ8bVRtrts/KBsq8qlTn4csxEcmJM=;
        b=xGz52WbGTEMkoQC6FiAEmDGWIsWi+FwNsCo/XGB9MbUEylSiGZZa0wE/ckc/tXmVkE
         XBuX6rYReHPftiXvROmWlUtC5yVQYwdO+Wa+81EabFIwnY3jQq8fcxE3gB53wGQvIy4j
         20b0OK0aMWQQWsMmb+YBLGB1B4q6/3wWhwytiJ54yHZwWnLvJgJ4NGRBitVvCn0/bvU9
         mHD2HUJnXBUj6FcWxM5axH0VhHQFIn1Pb1pJppAwFtCZhYkYt18ahtrDfw60NPK7ocBY
         CYYzMyefa1fI53naC0uOD13kdUY/9ncyeQ4Ll8+ktwTHXx4VLiAmhzGZ5i0O40UnnvSL
         oC8A==
X-Gm-Message-State: AOAM533HHjNQaDrEkXOVz5c9ybVzGH8NLaZfE9KNriP8tY/T2+LH08M5
        EN9GVipxtrwfmd1NyTU9WSv9QCWF0rEz5hy5w8Uw53JifIkh+g==
X-Google-Smtp-Source: ABdhPJx9q1kbuihzWOpIMVGesSFDrqjpZ+Sz6EMAYdSuIDZOshfPmIzteJPCxNz+HqMHCLS0pklBPQ1I2ymMWT+nj14=
X-Received: by 2002:a05:6512:238c:b0:448:5c84:29cb with SMTP id
 c12-20020a056512238c00b004485c8429cbmr1401270lfv.498.1646873128340; Wed, 09
 Mar 2022 16:45:28 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6512:b83:0:0:0:0 with HTTP; Wed, 9 Mar 2022 16:45:27
 -0800 (PST)
From:   "Capt. Sherri" <latobaba3@gmail.com>
Date:   Thu, 10 Mar 2022 00:45:27 +0000
Message-ID: <CAHi4Utnv8oQb8TBVL8JEg-Y-P9FGRypxyHmU6Oxv0DcgR+W+4Q@mail.gmail.com>
Subject: =?UTF-8?B?5Zue5aSN77ya5L2g5aW95Lqy54ix55qE77yM5L2g5aW95ZCX?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

5L2g5aW977yMDQoNCuS9oOaUtuWIsOaIkeS5i+WJjeeahOa2iOaBr+S6huWQl++8nyDmiJHkuYvl
iY3ogZTns7vov4fkvaDvvIzkvYbmtojmga/lpLHotKXkuobvvIzmiYDku6XmiJHlhrPlrprlho3l
hpnkuIDmrKHjgIIg6K+356Gu6K6k5oKo5piv5ZCm5pS25Yiw5q2k5L+h5oGv77yM5Lul5L6/5oiR
57un57ut77yMDQoNCuetieW+heaCqOeahOetlOWkjeOAgg0KDQrpl67lgJnvvIwNCumbquiOieS4
iuWwiQ0K
