Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539A8515CEB
	for <lists+linux-scsi@lfdr.de>; Sat, 30 Apr 2022 14:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359740AbiD3Mgr (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 30 Apr 2022 08:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358260AbiD3Mgq (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 30 Apr 2022 08:36:46 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0F3532DD
        for <linux-scsi@vger.kernel.org>; Sat, 30 Apr 2022 05:33:24 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id t5so1210192edw.11
        for <linux-scsi@vger.kernel.org>; Sat, 30 Apr 2022 05:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=rPi59H+VU52AaZj80KkE+d86t7d/yVo/kpw5tZvldnQ=;
        b=A6eBH4qm3EyfQg4fJ9A7p2eMKbkdS90hFWEgOwUyve9UtR1cH4fcjb9Ai3wHHRJyrD
         UOlTEObqBY9CFynrF+JcdKvgg5QlXqHvRzMx/d22oEl6+BtKd8jHTQmuColcnbDyoov9
         Ouzts6HnLqBOw8hk9O9kHjCtrrhIobkc0lCYv5C2+SW4KW+Vsft7f3qwNuusQWBy0m97
         xZ1aiS04yfJJ2J85D5kUnpHT4H3fW9/ySQ/F1rJ2z6f1eaCot7KWNGDTmiDL+fI2WIvF
         ZiS6qkQzvIudBF/3vaEzmbZ+uhW53XWFVGunuCi0d4/QHGwE9Lg+PZvQxVbNf5he5NUR
         k7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=rPi59H+VU52AaZj80KkE+d86t7d/yVo/kpw5tZvldnQ=;
        b=H/L6KqB8hmXShTBr9GxbZGZadlSDY1fBaOuT+LVeQ+3rVPBZ5aCvixlpbaDVFnB3FG
         6C6xxCxBqRIUJjLJMeg9bJbR+PrtEMi4RdT4e1GkuRIUnvHCe2NfsDiKzFALMyRxDQZY
         wQZVzCdhepFC9F26ZAqe3DzcdNjpZlgrQC10l4Uqur75WcE/F3lenOEc2Y7p9uAARHTx
         cn6nubp27tBOlT/P+2I9jko/uv01GAl0tDH3K8H962UrdGk1fR/yUZzYZdTzoNdj0fQj
         4lrpfa7D80qhx9ATVq0xSxM/4kX1AxAD4vEsS4EsQVFxqBsAUvEvsokPaV4oPOxd9wva
         widQ==
X-Gm-Message-State: AOAM533qSYpCMydWJmE3LpHMIUJKEC7vE8muYFJyjfr8fHBa2oO/EyfA
        jZMe58rhOeTygXXtCEBSGghaMNBnz3Z6KAwLsQM=
X-Google-Smtp-Source: ABdhPJxcdJmhtFayxiKInwv8L/1qFRSJ9iy8Cehb1H/azk+jme2CYxKsLHrBJfGN0WC6Fdg96qWVsd8fi186bHEHcKY=
X-Received: by 2002:a05:6402:28b1:b0:425:c39e:b773 with SMTP id
 eg49-20020a05640228b100b00425c39eb773mr4103155edb.237.1651322002938; Sat, 30
 Apr 2022 05:33:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:906:e104:0:0:0:0 with HTTP; Sat, 30 Apr 2022 05:33:22
 -0700 (PDT)
Reply-To: infor.atmbankofafrican@gmail.com
From:   Samuel Sam <sam697523@gmail.com>
Date:   Sat, 30 Apr 2022 12:33:22 +0000
Message-ID: <CAK3oMyMsM9+ZoqD8m3Q-Bt=oT3gfErs+cX4Sy6HgJxerAh0_xw@mail.gmail.com>
Subject: Richiedi la tua carta bancomat da 1,5 milioni
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:52f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [sam697523[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [sam697523[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Gentile Beneficiario!

Mi chiamo la signora Kristalina Georgieva, presidente del FMI. Hai
abbandonato i tuoi un milione e cinquecentomila dollari degli Stati
Uniti con la banca unita dell'Africa. Qual =C3=A8 il motivo, chi sta
cercando di ingannarti? Perch=C3=A9 questa =C3=A8 l'unica banca autorizzata=
 con
il signor emeka chris come agente autorizzato. Se rifiuti di
contattare il signor emeka chris, il FMI non ti consentir=C3=A0 di ricevere
il pagamento e continuerai a lavorare con le persone sbagliate per
tutti i giorni della tua vita senza buone notizie. I tuoi soldi
rimangono ancora con UBA in Togo e devi contattare il signor emeka
chris se ti interessa la firma e l'approvazione del FMI.

Agente autorizzato: Mr. emeka chris
Nome della banca: banca unita dell'Africa
E-mail: info.atmbankofafrican@gmail.com


tel: +228 70072268

Questa =C3=A8 la banca approvata dalle Nazioni Unite, dal FMI, dalla Banca
Mondiale e dall'ECOWAS e senza questa banca menzionata nessuno di
tutto questo agente ti supporter=C3=A0 o approver=C3=A0 il pagamento per te=
.
Si prega di contattare la banca ora e ricevere immediatamente la carta
bancomat del valore di 1,5 milioni di dollari.

Cordiali saluti
Kristalina Georgieva
Presidente FMI.
