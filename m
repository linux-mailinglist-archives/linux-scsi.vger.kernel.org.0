Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 102734118B9
	for <lists+linux-scsi@lfdr.de>; Mon, 20 Sep 2021 17:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238609AbhITQBG (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 20 Sep 2021 12:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbhITQBF (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 20 Sep 2021 12:01:05 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8874C061574
        for <linux-scsi@vger.kernel.org>; Mon, 20 Sep 2021 08:59:38 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id u18so17883643pgf.0
        for <linux-scsi@vger.kernel.org>; Mon, 20 Sep 2021 08:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=xES4OnoNhzyjiUu2UjjCQFZvDFg9jPphEXhhhirchEQ=;
        b=G2cZdCGWOG+3inoZp1O4qA+Tmswdzxkkr4sPM4MHELj+bzLFnYnS9iuE5A2Va6MA/m
         ixSGpD/PA/1jgULiSxsF3B1pX5hSoMJW60k5jw/O1FFfFx6aUJslDtYjvW190fpIQ5Hn
         BHJAP3selh+p3EyhhFk+A4nwcYD91enRHOXDxLgMXPYJdRiOmC+XVBB//9Vl+523Lhuv
         P+8EqRampZKwOta1lQ34HhM4mDzTYe/M0W+U3WRDRA+CkuowcVj/bhNxCDpcOKQ6OrMy
         OgMc4CVcNTPmsJrX5d6UfGxeYA2fpu3HzZMBIVkobEu0B8eqxemNdzJVwfi00yP/EdMt
         jC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=xES4OnoNhzyjiUu2UjjCQFZvDFg9jPphEXhhhirchEQ=;
        b=Uf50mfc14Cte8PmmdLXm8aJNHVrOa9NIgy03Hw06M8KZT/2OtxXERrUZf3cwihcTE1
         /mQhRdvMzj2ui1aV7P/zjJBeemEpcV7b+d6zhemla9vMFzUkJmhsIMJv7hjIkS+S7hkn
         HfqAT50IdGq1likaTF6b3XZFtPUbTQXJiSAkrbU1K7QUDNFl1mQwS9zc+j+9IXtHJ3I1
         nGBs7ZDGWqs6rws7WzQgRb1cA3sh6w3UbvYHHdKH821YUC1+U2Kxf2nkI6f3r3Ok1hKh
         FuOU58mBATSfNhGWd5nkweHxCXJqHhM5ZemgQccYiQc77hiODxC3D4TP0kQEGOeZ4AIt
         Df6g==
X-Gm-Message-State: AOAM533TOlQuiL+gdnyctEJ9+BxNDllyguNl5jJCFbX+iChMzaP3nf6u
        SFiivMOo+GRvXCUcBZrpg7ksKR5FNRYq21Er+OA=
X-Google-Smtp-Source: ABdhPJycwBjMmeIr7vQVCsjgyZEc3tHwBlHU1Bil8yrSEDgARwT75Rqt1/HEXsuY94cg/O6FVO/2GXos2kUC9zVJ3VQ=
X-Received: by 2002:a05:6a00:10:b0:43e:ede6:2b7 with SMTP id
 h16-20020a056a00001000b0043eede602b7mr25882214pfk.42.1632153578180; Mon, 20
 Sep 2021 08:59:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7300:2ca:b0:3e:c8e8:ab21 with HTTP; Mon, 20 Sep 2021
 08:59:37 -0700 (PDT)
Reply-To: mis.haleema.zamani1@gmail.com
From:   Mis Haleema Zamani <abdulm28421@gmail.com>
Date:   Mon, 20 Sep 2021 23:59:37 +0800
Message-ID: <CACn_fYPxELjDjpVj24XVmW3EUGKJ8+0DM23-4-tPT5RX9GMunw@mail.gmail.com>
Subject: ICH BRAUCHE DEINE HILFE, BITTE
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Gr=C3=BC=C3=9Fe an dich mein lieber Freund,

Mein Name ist Haleema Zamani, ich schreibe Ihnen diese Nachricht mit
Tr=C3=A4nen in den Augen. Der anhaltende B=C3=BCrgerkrieg in meinem Land Sy=
rien
hat mein Leben so stark beeinflusst. Ich habe letztes Jahr meine
Familie verloren. Mein Vater war vor seinem Tod ein reicher
Gesch=C3=A4ftsmann, er machte =C3=96l- und Gasgesch=C3=A4fte, er machte auc=
h
Goldgesch=C3=A4fte. Er hat viel Geld verdient (F=C3=9CNFUNDZWANZIG MILLIONE=
N
DREIHUNDERTAUSEND US-DOLLAR), das Geld ist bei der First Gulf Bank in
Dubai, VAE, hinterlegt den Krieg und das T=C3=B6ten in Syrien jetzt.

Bitte helfen Sie mir, das Geld zu erhalten, und wir k=C3=B6nnen
vereinbaren, dass Sie es investieren, bis ich mich von meiner
Krankheit erhole und zu Ihnen komme.

Ich m=C3=B6chte Sie als Gesch=C3=A4ftspartner meines verstorbenen Vaters
ernennen und die First Gulf Bank in Dubai wird Ihnen das Geld
=C3=BCberweisen. Ich werde Ihnen alle Dokumente und Informationen f=C3=BCr =
die
Einzahlung des Geldes zusenden.

Bitte lassen Sie es mich wissen, wenn Sie dies f=C3=BCr mich tun k=C3=B6nne=
n,
dies ist meine wahre Geschichte, bitte brauche ich Ihre Hilfe.

Sie k=C3=B6nnen mich per E-Mail kontaktieren (mis.haleema.zamani@gmail.com)

Mit freundlichen Gr=C3=BC=C3=9Fen,

Frau Haleema Zamani
