Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E23C23CA29
	for <lists+linux-scsi@lfdr.de>; Wed,  5 Aug 2020 13:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbgHEK4V (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 5 Aug 2020 06:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728193AbgHEKuE (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 5 Aug 2020 06:50:04 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6BCC0617A0
        for <linux-scsi@vger.kernel.org>; Wed,  5 Aug 2020 03:24:57 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id l204so10365502oib.3
        for <linux-scsi@vger.kernel.org>; Wed, 05 Aug 2020 03:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=UOr65DEC+2TW/zt7uOWWliltVKZ89UsSxVAE/jQE1oM=;
        b=B66ZcTXEjsnpPty+Wf6Ruyhx6dz9qKkxKqb4ddmpgIPU1IkkeHcm8cAuf9TuVlkkkK
         LMxVzLG/GLlCxlZb2Y1/OGXLp5QNTXaGc8vvvrXHOZEfraFRgAj/p2mXQvk1HjH1/sWK
         UwiphMAIjn7YXS/uLgxCTMnI+OfnDV7dT/tFuF3Msj5kDqPmLHAfGj32MRVV1W55NGee
         +h9NxPLdq9HmzHfb09WVi0g0br1/SpTrSlhfHIlb1wUGDNm9Gri8aNe1rEyyZpYsuqkj
         7sW/zEmL9VCIcLki/3/YXfwxjJ1eoqXgo/aDcLcVpMJbdhl1EYx+QJIdEDFZXGkZddLy
         P8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=UOr65DEC+2TW/zt7uOWWliltVKZ89UsSxVAE/jQE1oM=;
        b=jakHTxNdcnW+rG02QjVAeWtPN4KJNxzuxNx4YW4c0q3L/zr/tOFrTeR1KWJBy7bzWl
         0NBcz8rtxCmTIyuCgAFoO2Ej0bTnKjZ/KN4tD7GzrBY2YrrYfItiOItO11PB84rCD8mR
         lRTRwEQkubFlsQN9xm4bqoUG1NLGvpyFEy7YzoB3Gps+TktJ73UW8SAj1NOXitHGxJsL
         C8Zb9PtOl+sguqFpmSlHa9u5R7zIXBi6uPblIoVp4A4GTk6RAGnQf89eJQXLI5yeABjz
         ++nkQbouub6i1IIjopRs7t7xwbDTkk4CXkPMAshDEmQFWlO1j6nUGGcmy96tFgrc8sbH
         t+jg==
X-Gm-Message-State: AOAM532c51dRwkAtjlV0QeVBKINrP5YhnYtGi5OyCZaE/aA0ssiD3QWL
        WmdL50WDacz2AW/nCkoyItOU8hmxMsPd9+bL0kw=
X-Google-Smtp-Source: ABdhPJylLPuxjlI4kmrIqZPsriTRS7m9cqBfXBEpbfUFfECy3HY1ppQDkSSqXRXsMwf2EsKHn1rc6EyIKYk+o1xF89w=
X-Received: by 2002:aca:cc0e:: with SMTP id c14mr678566oig.96.1596623093302;
 Wed, 05 Aug 2020 03:24:53 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mrahmedmuzashah@gmail.com
Received: by 2002:a05:6838:e410:0:0:0:0 with HTTP; Wed, 5 Aug 2020 03:24:53
 -0700 (PDT)
From:   "Mr.Ahmed Muzashah" <ahmedmuzashah@gmail.com>
Date:   Wed, 5 Aug 2020 11:24:53 +0100
X-Google-Sender-Auth: J-7KobIqVQTB9cxd94PGJld5kjs
Message-ID: <CAMydiEb35tnrqcn7Wb5f9=f-xdrunbRJJN6=DtQzUr5KoNwutA@mail.gmail.com>
Subject: =?UTF-8?B?U2Now7ZuZW4gVGFn?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Sch=C3=B6nen Tag,

Bitte entschuldigen Sie, dass Sie einen =C3=9Cberraschungsbrief geschrieben
haben. Ich bin Herr Ahmed Muzashah, Account Manager bei einer
Investmentbank hier in Burkina Faso. Ich habe ein sehr wichtiges
Gesch=C3=A4ft, das ich mit Ihnen besprechen m=C3=B6chte. In meinem Konto is=
t ein
Kontoentwurf er=C3=B6ffnet Ich habe die M=C3=B6glichkeit, den verbleibenden
Fonds (15,8 Millionen US-Dollar) von f=C3=BCnfzehn Millionen
achthunderttausend US-Dollar eines meiner Bankkunden zu =C3=BCbertragen,
der beim Zusammenbruch der Welt gestorben ist Handelszentrum in den
Vereinigten Staaten am 11. September 2001.

Ich m=C3=B6chte diese Mittel investieren und Sie unserer Bank f=C3=BCr dies=
en
Deal vorstellen. Alles, was ich ben=C3=B6tige, ist Ihre ehrliche
Zusammenarbeit und ich garantiere Ihnen, dass dies unter einer
legitimen Vereinbarung durchgef=C3=BChrt wird, die uns vor
Gesetzesverst=C3=B6=C3=9Fen sch=C3=BCtzt Ich bin damit einverstanden, dass =
40% dieses
Geldes f=C3=BCr Sie als meinen ausl=C3=A4ndischen Partner, 50% f=C3=BCr mic=
h und 10%
f=C3=BCr die Schaffung der Grundlage f=C3=BCr die weniger Privilegien in Ih=
rem
Land bestimmt sind. Wenn Sie wirklich an meinem Vorschlag interessiert
sind, werden weitere Einzelheiten der =C3=9Cbertragung ber=C3=BCcksichtigt =
Sie
werden an Sie weitergeleitet, sobald ich Ihre Bereitschaftsmail f=C3=BCr
eine erfolgreiche =C3=9Cberweisung erhalte.

Dein,
Mr.Ahmed Muzashah,
