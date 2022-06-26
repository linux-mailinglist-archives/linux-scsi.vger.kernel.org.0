Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF3555B042
	for <lists+linux-scsi@lfdr.de>; Sun, 26 Jun 2022 10:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbiFZIWr (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 26 Jun 2022 04:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234128AbiFZIWq (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 26 Jun 2022 04:22:46 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDE212AD6
        for <linux-scsi@vger.kernel.org>; Sun, 26 Jun 2022 01:22:45 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 68so6295361pgb.10
        for <linux-scsi@vger.kernel.org>; Sun, 26 Jun 2022 01:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=wc2qIUs5aFSXcRjV7G8eRxSHIE5Fs0BRqGwQ5dxHs30=;
        b=dFAkOYrRD6JBtxB5anAm3g+S32oKjT0GAC3stYkdZdXt/4ObtTfIEwDYbj5C3l5plA
         uQ/TRtGRGo/kYveSAqP63tcy33QGV/G1DkgodPm/bAtvcR2vlvxx5IzrjmSnf9bqF96d
         e8oA1/BpDSPubA071WNODA52IMRaM3rqoP1AIgfI2AnDf623OlMOjEVzo6fhR+Ewb3vc
         4YwLiohv1Qu0Y6uZrb31Qu+LARLJq4rS11m0bXE1Mb+6x5cKSCt4gNYs+Aqw2Jg/X5yb
         9LSjMAk0/vZmm0a9WYruqmWbDkq1M+MxN7PQ0dRdfkUCPbNVdAx0RLi6BWC/0cEKuDnb
         JaqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=wc2qIUs5aFSXcRjV7G8eRxSHIE5Fs0BRqGwQ5dxHs30=;
        b=cT4mbdq+efdgaoD65b9/k58jpLdBrUbYHEb3GEelw9daHyxV/6GyYwjESKRnlioYhG
         9xaS4u/GPvJR+iJoSB9RyzzQpEljHT+XgGBVQqW3nMF0o5Vsuxr5f4QqWPtRXDO2RZPb
         01oZ1ehz1xBYGZQf+ADFwtdG+2xXJo+54HH6oflF5JwRUfIgNO0RnVUfYgfaltuO2RjT
         eABf2b3l60gT6R0W9e422AS9RWMhctBRuxZaKTl2rEmXF607n2S7iv06mGZF5jC2mFDd
         8o7KOZA/PLQrIjl3/JdaX/y1DN1cGRUHmjUpTIzvhS5P/TOPTJ9SpBWSdzzqZeZ9Eab5
         F+3w==
X-Gm-Message-State: AJIora+kCRCWNoN+D+fyirFAZtvF+cIynRAQlFw2H4Xiv9jvB76y8qPJ
        kQRS2savZr6yKdoMDIp498WOfSUddc38mkmSDw==
X-Google-Smtp-Source: AGRyM1sGDjNYX4fumI101G0chNQ5K8tzp5Wnq22Jt2fltY+8Art+93FPmmSDifOgWWH3jqFdWglNI01ObUoNErP11s4=
X-Received: by 2002:a63:751b:0:b0:40c:9c39:c890 with SMTP id
 q27-20020a63751b000000b0040c9c39c890mr6969077pgc.302.1656231765417; Sun, 26
 Jun 2022 01:22:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a20:c89b:b0:88:2c1:a3 with HTTP; Sun, 26 Jun 2022
 01:22:45 -0700 (PDT)
Reply-To: infopeacemaurice16@gmail.com
From:   Peace Maurice <gnozikobref@gmail.com>
Date:   Sun, 26 Jun 2022 08:22:45 +0000
Message-ID: <CA+DSXpd6JkeAuqOmjGjyR96NjDSgNoRocWZf+Qu4dg=sSTUUAQ@mail.gmail.com>
Subject: Hallo
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Ich habe Ihnen vor ein paar Tagen eine Nachricht geschrieben, aber
keine Antwort von Ihnen?
