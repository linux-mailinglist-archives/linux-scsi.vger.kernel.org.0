Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F3633007E
	for <lists+linux-scsi@lfdr.de>; Sun,  7 Mar 2021 12:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbhCGLvf (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 7 Mar 2021 06:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbhCGLvO (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 7 Mar 2021 06:51:14 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3DBC06174A
        for <linux-scsi@vger.kernel.org>; Sun,  7 Mar 2021 03:51:14 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id b10so7136845ybn.3
        for <linux-scsi@vger.kernel.org>; Sun, 07 Mar 2021 03:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=tK9+oluddhYE1y6+vcMj+TPM/NY0V1ncs6jMbGXJvC4=;
        b=DdYFt/x2qzrAFNrkectk5hCZCFCma3z1en5HcrP9D/YFpLN7f8ErJLdTzV5JDOx97X
         QUjU6q2AwfuVs3Dh047RH2Nme/aWPx7wxm38nrcB2ek8+BM1vka0mAmOK3g3+A1xDV6Y
         wpE9q8YZA2bofWcxwwBzfRlm/C0+5sKhHIS2k2NcdnHE0osyalZP949FF4Es8gfKtYKJ
         1j4acu9aPgKb7/HfMy7sVPBfcoYfVw50zkeJVnBUIPslsIKwGTJ96wejtaQJ8Vv9/XjR
         YoKClnEijbgsgFlu1W9ghOAygeZfWTo3c2aNSDQHksHZx5TTT18ZYF0/5rIba5ZYJyk3
         E4Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=tK9+oluddhYE1y6+vcMj+TPM/NY0V1ncs6jMbGXJvC4=;
        b=nDVikLnmpsOUTWfb7PennV4QKyQp0Eh7graL1tosrcISitDCqA6Yi+99lHWLTXVskt
         DyQiKaNwA4cjC/XefcAQxJCFdvjfHpbuiGM4T+yF5JVcJ7OW0Uzp35ObWPJG/CsNfVDm
         Jh961iIdjh01d6bapH5dWZKtIKZA/XdRa49C7Y4vIfGD6lhk94/ndXnb7eGJR4gytK8c
         KxWWNERFTb5L7iFhBYyxqNHJiYtNqjXmtWFx+4dRdCNSoa+9i4pOpa/bh+j1UFafScXv
         QdXXW6aR9u9+Uj2URvcZSJDpOkJl+KBVPibGAiiZBs8z0t/IxuKfWiHwFQ+2ufy2R+LQ
         yfeg==
X-Gm-Message-State: AOAM532PV0ybP++nwfXNDMelYegd/ftqFroqaCq2XGsjm4HLeduJNy97
        mZvzScy8vuVyzt2q0Tu+f5omsSNmn4AXzHgEqGo=
X-Google-Smtp-Source: ABdhPJwXkeOHZVZo9yMwGhmE+xT2fwM3JgD+vlVW4bfkhBDDMxmDu84knT44f+AVNMbss0NuvUfNFeDHc5kOktb9Q40=
X-Received: by 2002:a25:4054:: with SMTP id n81mr25316424yba.39.1615117873263;
 Sun, 07 Mar 2021 03:51:13 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7110:3355:b029:31:9414:7f4 with HTTP; Sun, 7 Mar 2021
 03:51:13 -0800 (PST)
Reply-To: erick_koffa@mail.com
From:   Erick Koffa <erickerickkoffa@gmail.com>
Date:   Sun, 7 Mar 2021 12:51:13 +0100
Message-ID: <CAJ5udMsiA=O7ogA9ZvXCqybtXw82EhAYuo9eumnkb9E8N=bOxA@mail.gmail.com>
Subject: Re:
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Greetings from Mr. Erick Koffa, I can talk to you, very important please
