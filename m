Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6599B311E2D
	for <lists+linux-scsi@lfdr.de>; Sat,  6 Feb 2021 15:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbhBFO5r (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 6 Feb 2021 09:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbhBFO5J (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 6 Feb 2021 09:57:09 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302CBC061225
        for <linux-scsi@vger.kernel.org>; Sat,  6 Feb 2021 06:56:04 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id y18so12857608edw.13
        for <linux-scsi@vger.kernel.org>; Sat, 06 Feb 2021 06:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=sY4fgq/DSyThalwU7QX+pWYKs/8sGH7ZznMUn5qQ1EY=;
        b=LKTydslwkBHjRBD/0U/iTEH4rnbV3bQM+PEGCYVnKRWqCpBuxiyyJWlH+XxoDVh2b/
         HFZWTfmHMpqHsMdZMtB/2gIQb6SrU7HNNg4Pbg6aDUnwTTYa4ErmhrI4rReQ/aAXsVVq
         wwdcwN/6PaD+QIBMSCrJ3tjlNWUWWctCNR4ZtJFT9jJA61Cvt48scMGk7sXyE5r6ccDR
         P3Y4T1+1qudMtHcSBxbPHr6TwKJ2cZ6qwDAUiEhK7eJUvy9B8fetIBZUma+T+Fz/B+MD
         X/a9+Uu3zKZgMCYnPeP2cVIikCY3zOffZKfAVZgicLkOAYPws+uBFNEJqRYUVgffaWvv
         FXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=sY4fgq/DSyThalwU7QX+pWYKs/8sGH7ZznMUn5qQ1EY=;
        b=RHPgfhU1yTy0O51v51zoSX2de+0m+ft9WfX6jK7eDbEvqtk73GFVu2g+sqHwwcp77i
         LRCFc8tEs/m78tU587rp9mvMidi4+2hYeaAMLXDyI7AcPWUQe6Y34JfEigVl3SRk8FSU
         ob+h6GbInAp1RjjAvDLy1Z7IhCLf6U5KSsARwXlz/qcV92bORnq4DH9Xk+P+xNTrZQqe
         yp4o1kKgRSdKhrWQjdWNJoClKCNahJuk47+wjpB0g5A7I3lqzsJ7OMKlKtWyU7NxYvM/
         3oh/mKeRPMOosB8qt0n214ERYt2Nq5UDz/xoMAovPNnRrET/w5EKw4Yp2xUMgvdq3DXN
         /5ug==
X-Gm-Message-State: AOAM530PL+9caCOuYdf5ofOZqTTzi2dqV476lNBX8XDurb+tMyzSscSW
        U0VaJMzq3EbPnCaTmEvNJb7WSb6llq16eYvbE2ehJuOJCxA=
X-Google-Smtp-Source: ABdhPJzHuK3LvHqbpz7y7FkmfdCO+mLpCyAcQI6UI8feOQjxzQakBQkfzu17R8y2ODfxQ2tLrHWIUKNuNGqsXo7YnO0=
X-Received: by 2002:a05:6402:3508:: with SMTP id b8mr8823036edd.341.1612623362722;
 Sat, 06 Feb 2021 06:56:02 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:906:25d0:0:0:0:0 with HTTP; Sat, 6 Feb 2021 06:56:02
 -0800 (PST)
Reply-To: lawyer.nba@gmail.com
From:   Barrister Daven Bango <stephennbada9@gmail.com>
Date:   Sat, 6 Feb 2021 15:56:02 +0100
Message-ID: <CAGSHw-BTtjFX0_eZQxh6ESq0ccY53ZvhP0ukJTUOzzjPJEQARQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

--=20
Korisnik fonda =C4=8Destitanja, Va=C5=A1a sredstva za naknadu od 850.000,00
ameri=C4=8Dkih dolara odobrila je Me=C4=91unarodna monetarna organizacija (=
MMF)
u suradnji s (FBI) nakon mnogo istraga. =C4=8Cekamo da se obratimo za
dodatne informacije

Advokat: Daven Bango
Telefon: +22891667276
(URED MMF-a LOME TOGO)
