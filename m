Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8FD3F90FB
	for <lists+linux-scsi@lfdr.de>; Fri, 27 Aug 2021 01:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243722AbhHZXgo (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 26 Aug 2021 19:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhHZXgn (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 26 Aug 2021 19:36:43 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA60BC061757
        for <linux-scsi@vger.kernel.org>; Thu, 26 Aug 2021 16:35:55 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id q11so7551266wrr.9
        for <linux-scsi@vger.kernel.org>; Thu, 26 Aug 2021 16:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ARNGsdh18aTDUf5LQl8EpRH6zfMP8KoRGSsMRfX79lU=;
        b=M+CRbGjPZ86DTn1ZUaToXrpieI2+ksonmJpvqW8WzRFrVU7yIpVKNt0ql+EfwjNhpp
         npmadmc0h5obipoG+d8hnVEUED4RdgUACRjVxsW5MUGYDUx2lcVVhlkhQEAj4YctrzT1
         jxTFEinMDK4ZsO3hmRYS3yll9gutrnhE01vIxuHatKrbfrE1ah7hLoDAV9wCJB2Wmyto
         Lsx8Jt2qeuZ1lZQhllCSK1b1M6NktBRFAB/To+68rs3hL1TFjD9RGXl44PUMk1ntLFIa
         euLwLeZsleKMwT8M46r5ea0WUve/BN05xbxiysSRweSJRWuaQBuXtQjkeEH6vmhIWktF
         HWGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=ARNGsdh18aTDUf5LQl8EpRH6zfMP8KoRGSsMRfX79lU=;
        b=jJmdlm4zypgj5rY9skE574utLPtRrH8YyM2+JBlPBFm+HxJLKDXqogTvlrDMOty2V1
         C7X1TdSQ4mnOh0E7BCV915C3iHr8Om46JNJcA1Rrn0AlbztqAdRBTI4mDuwjTQxAGqgN
         NcaLD7suxbemZSQjWyP92zodiZcgUxTcr+tmxixDXN2PXgjRUFkTyAkHdOcN6MwKVqdD
         xqOT1qZtUEM9SxxWksbmD13cQm6K1je9K267MAZPGBUuBVx9QubSe1Nvx6h03eLwsFvJ
         yqO/JeWetIowJfkudy7WtpWUCxTAD24u4Chnx2zNq33F7aVZl3LmR3nGAsRKH+YGLESp
         yhUw==
X-Gm-Message-State: AOAM5303w/1S0XClSfc5sapsnT+Q5n/zfwL8sQQe9dQBI+tYbVns950y
        2XKEjmRRl393OYcbMAnGI/CiJJkCCQc/niXY02k=
X-Google-Smtp-Source: ABdhPJwqDgrktbw2mtPvxHviQoGU6lkrV1W1sF+MdQy275y1yHxSiaANYmcV3rSaG820srM8RZojoTEOnl6VKtT2Cxk=
X-Received: by 2002:a5d:464c:: with SMTP id j12mr6661521wrs.27.1630020954356;
 Thu, 26 Aug 2021 16:35:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:5989:0:0:0:0:0 with HTTP; Thu, 26 Aug 2021 16:35:53
 -0700 (PDT)
Reply-To: IncCEisabit@gmail.com
From:   SABIT INCE <alfaroukkhadija@gmail.com>
Date:   Fri, 27 Aug 2021 00:35:53 +0100
Message-ID: <CAF1Q0Jnfk89vAiQAp61JfWAxfENvjm39XCOMTD=fexi88iw85A@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Cze=C5=9B=C4=87, jak si=C4=99 masz?

Czy mia=C5=82e=C5=9B okazj=C4=99 przejrze=C4=87 m=C3=B3j poprzedni e-mail?

Rozumiem tw=C3=B3j napi=C4=99ty harmonogram, wi=C4=99c nie martw si=C4=99.

Odpowiedz jak najszybciej.


Dzi=C4=99kuj=C4=99 i pozdrawiam,

Sabit Ince
