Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B993041684C
	for <lists+linux-scsi@lfdr.de>; Fri, 24 Sep 2021 01:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236363AbhIWXHT (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 23 Sep 2021 19:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243492AbhIWXHT (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 23 Sep 2021 19:07:19 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09389C061574
        for <linux-scsi@vger.kernel.org>; Thu, 23 Sep 2021 16:05:47 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id t4so25774356qkb.9
        for <linux-scsi@vger.kernel.org>; Thu, 23 Sep 2021 16:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=dbiqOQhkV4brHmNgYUPaK3qcrMQfv2CyqM36P297Q3Y=;
        b=Aw6S76p6T8z4MQrRRs+iAbeaxTnqsdGKKlsiTfWA0xh/FO0YZ23o1tpvBATzDvdPzQ
         aTWgzGvOmtzTyeGO/U0mSop7W2WmQCA0IgijUEDuuASf0wxI8KN29gVg/BRicsSuqIJi
         b8hdNXgWSef33h0bImqJzKWlzOq8xYpjbnts2/btXRkRbzVJzDa/evgr7XYP0uMAI+Bc
         ibRD1/1Qg/v39P9Q9e3AzFUlBWKnl05TFoaY6vzh5wDu47PXZby79LngWlLQrluHd1R+
         tyV5VE9D8aBC6mDlB5TadCkliMgq6xR+3rJTTAh9uRGdVlk6MEydEAqa34HseSlA5Yic
         on/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=dbiqOQhkV4brHmNgYUPaK3qcrMQfv2CyqM36P297Q3Y=;
        b=MSPd5nq+9m6d0XdcERH77mUOAxLQvELG00XjN7lboQb9eHD9udpPYACyPAOG9/uthc
         ZxHkiopKU3QA/l8f3NpDIJIiOaBYNCwufC9kMriYh75g1iDtMraQ/AWBZ90eSsQRJrHD
         96HAylcNu0dEuUB+N+PYYDCEIw87UBDxNONgII/Scfv5gvTm84dRJtDDjyDcn8xmYKvP
         r5k/wGbtOmIiaX2UxBKAAu9BMQ6wdHn/Z1fyhna9xinMQflyLgV0JcqARobWS5e0Uufw
         9GkR8JykbEdmUTrTGfmT1RfET4xW2E1Tn1LJOHpFx9sFCZXEYgaxjaF9RMjhWUmjNKAB
         KntQ==
X-Gm-Message-State: AOAM530B8IMlKQLPa19JBqWPRcHdMrwVrvo00ceqp7MzVDuOBg1aLrgI
        4gf1eHePqqOxlsEl9brYQrnrFR5yZEBsrHkF2k4=
X-Google-Smtp-Source: ABdhPJzAHjCk2gFG4gPgDnMd4nB8/eTPQ6uQOQIIn8RyE42N/YuJTgOnaj9g1+r3FK+//R5u/kdUUu1Jqa2QPiy/QDM=
X-Received: by 2002:a37:8a43:: with SMTP id m64mr7429955qkd.285.1632438346126;
 Thu, 23 Sep 2021 16:05:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:622a:208:0:0:0:0 with HTTP; Thu, 23 Sep 2021 16:05:45
 -0700 (PDT)
Reply-To: cherrykona25@hotmail.com
From:   Cherry Kona <fernadezl768@gmail.com>
Date:   Thu, 23 Sep 2021 16:05:45 -0700
Message-ID: <CA+J-fD5AjQ2ePfCAs5fU+pQoFGsVcS5er663HLmJ-CNBq=QOUQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

-- 
You see my message i sent to you?
