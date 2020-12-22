Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3802D2E0E6E
	for <lists+linux-scsi@lfdr.de>; Tue, 22 Dec 2020 19:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbgLVSug (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 22 Dec 2020 13:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgLVSug (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 22 Dec 2020 13:50:36 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03977C0613D3
        for <linux-scsi@vger.kernel.org>; Tue, 22 Dec 2020 10:49:56 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id s75so15782206oih.1
        for <linux-scsi@vger.kernel.org>; Tue, 22 Dec 2020 10:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=wjunn4+x2QEs4HRrQcozT7INn2DM0lGSHIZkmkDz3T0=;
        b=tlod9UGRoFBGK4NEy8TrcKskDGqmLfXmLKCX0XEnq7hK0iyRXxoORHmOr6pIkknCuw
         CCo11izJ0X8JQUol7T78Lr4qCx+17XzgkGOdh0lx4qjZ3AOW0fpfxmqwUMHCKAFtYrl5
         QI/ABOuqGGVfOkfxRJM1JJckKVI4uh/d4Otbz1airnzyLiJbJsZnK+Oiyz1OD5YcKH+v
         c1KMdZSr5lqkp1/gaUeg/SMdgp7KRdWPB7mEvhqXTt1EMsMFtKxF4uxgBBcotOzvAcSP
         SrNUltkJaBgDf7jIP3ipIJebq38H6VCvMb8mygIYnfvsUN8KjAMAAqMswsRnPZjIW9IL
         7sGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=wjunn4+x2QEs4HRrQcozT7INn2DM0lGSHIZkmkDz3T0=;
        b=P3gn5DinnjoCiYkolicIP5xijptNwhN9yKyVJ1nhmexOoekROIPYePfr5+XFvVevjN
         JjQbSbQ1vVMTTdHdxEzq1Cg0oDVCPFlMdGLMsGYjSCXPtsdID42iDOINXMW4F69B9mWb
         wO9rtY9dKaGcQBgqWcbRtPPXrt2eRE+9LwUi3I9xmBjsKtB3QthqK+DXo51mjqQguJ5C
         ZrWMlS1EU8QiGmqzqQywGEF3NAlIynlIX4LDUVqR9Km4ZZ4bp4vES8S4iS9ELNqw5nJ/
         BnsRhXhJ7p/7yQH3zJRACnAPQWxnlV3w3WZKBqJK93rDNp86PuTvUARHbFRk5s+e/V/8
         lEDg==
X-Gm-Message-State: AOAM532qGcL9VsOoCdXO+mh8Rv+7nCcScntNHmFUdeFl1Pyj83g4aFA0
        k0jSw037mTnOEE3SQviLoV1Xl+n3nfSAEnKzkwgWuZ9/CtKOyw==
X-Google-Smtp-Source: ABdhPJyPpLIkAzOcawqzp5n9beruISQBIBr9mTv9zaFn995WXVmLMHKv+NpCnfFLaPMXWx9EFBAftw2AC6hAkcfnLiY=
X-Received: by 2002:aca:acc1:: with SMTP id v184mr15867725oie.98.1608662995224;
 Tue, 22 Dec 2020 10:49:55 -0800 (PST)
MIME-Version: 1.0
From:   Abdollah Ashjaa <abdollah.ashjaa@gmail.com>
Date:   Tue, 22 Dec 2020 22:19:12 +0330
Message-ID: <CAGcpLaf2zEKyyVkrvuGO82pUdBaFJewfMPnUuCOteC0b1HsB9A@mail.gmail.com>
Subject: 
To:     linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

unsubscribe
