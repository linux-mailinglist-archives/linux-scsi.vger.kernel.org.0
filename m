Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32D9727FF0
	for <lists+linux-scsi@lfdr.de>; Thu,  8 Jun 2023 14:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235746AbjFHM00 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 8 Jun 2023 08:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjFHM0Z (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 8 Jun 2023 08:26:25 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CFD30C2
        for <linux-scsi@vger.kernel.org>; Thu,  8 Jun 2023 05:25:55 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-75d5469c856so46141785a.2
        for <linux-scsi@vger.kernel.org>; Thu, 08 Jun 2023 05:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686227153; x=1688819153;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2URvdto5eovnOZ9veTkEuCq8gCsNpoi88vZrtanDiw=;
        b=LgpyQBY+iU6ik73+n5Xif2M3IAjVaJpXywDoqyfj99Fm804yGwxLPgfWd7n/zrMcaJ
         OW92/cOUTHp0kbFCN2VRwpE9Gk19qsnWLBXczJY0MyTXnSzzye/FvMohQy/eSkDOJhbU
         Jd6zxxc0LtV79Gwz91HxrxMosubFwYjtb4aEYgadbLSRAMpSqA3bteUkLVRA8pqqtZi2
         wXbv5q4WbwkcPi/2Z0xzl0Ook6LdIAtXr1wNh9+0dAkd7F7h0VzV6kj+BvNv4CFTDz4r
         nGaO0f49YMxBaZWKD5ZkjNAQjHzw6qCXb0OCopsJxgnJk2zaeiOyCP+HBiYj3RZvKNye
         4J7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686227153; x=1688819153;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y2URvdto5eovnOZ9veTkEuCq8gCsNpoi88vZrtanDiw=;
        b=VN5xIM5vVeO5n+GLVDG3sPlEHhQ11E2X+ml3GvbDO3JxBMGuy+1jGIuhfegtxG1xeD
         iMC0/9SYQCJ9knfZ0mKUyG1MFnhzPSMcaQY0+XUt5SY1nwVw5isBRSfUgZlLQ6u7ZAq4
         OQ63HIaVZmiboObQ0SZWxGx6ImeJkvUhE3b+q0pad9x2Ogf/oWVwBedG4aGVzWYY1D7W
         pmd+AukYBPLWzQqkNtfjWLreKl1NNkdtOW/j+qX/bS/YPi9IshYueRVRmSbkiw9GVqt9
         r2elYab0Oh/LXuv+VmHMSSfH1/rw8yGOhMPenTJivRUs7OYSN17WKoJqhCKcC2vtkQMC
         sPHw==
X-Gm-Message-State: AC+VfDyTGE2CwDNPG0rLoGB/Dd6M8HaRo0iBt2cSBEUJ+0Y3Xjamx8Io
        Ti4zjsIJzVmbswV/CI1pu0fKfPtSLxwTRfljh7CSvIlkEiV0vg==
X-Google-Smtp-Source: ACHHUZ56CXoUQUcvzxm94pRLtum4/Tr+9T8qQhRCOVBk7qCpI3tDEmZf8YfJhgvLj3Yl6bmBElZ55sgX6f729xWZwXA=
X-Received: by 2002:ad4:5de7:0:b0:62b:4e7e:8aba with SMTP id
 jn7-20020ad45de7000000b0062b4e7e8abamr1232957qvb.60.1686226812125; Thu, 08
 Jun 2023 05:20:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:f5ce:0:b0:61a:6ff1:329c with HTTP; Thu, 8 Jun 2023
 05:20:11 -0700 (PDT)
Reply-To: markusblocher3@gmail.com
From:   Markus Christoph Bloche <ahmadtijjani3737@gmail.com>
Date:   Thu, 8 Jun 2023 13:20:11 +0100
Message-ID: <CAEHyr=3GFftQi8sd7C38Thnrk-hs_qqH0j1t=3zeW3w+NuoiPA@mail.gmail.com>
Subject: SPENDENANGEBOT VON 1,000,000.00 AN SIE
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:732 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ahmadtijjani3737[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ahmadtijjani3737[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [markusblocher3[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  0.2 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  1.3 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

HALLO HALLO,,

   ich bin Markus Christoph Bloche,
Vorstandsvorsitzender/CEO/Gesch=C3=A4ftsf=C3=BChrer,
Dottikon ES Holding AG. Ein Schweizer Gesch=C3=A4ftsmann, Investor und
Pr=C3=A4sident/CEO/Gesch=C3=A4ftsf=C3=BChrer, Dottikon ES Holding AG. Ich b=
in dabei
Das Ruder von 9 Unternehmen, deren Vorsitzender ich bin
Evide AG, Chairman, Chief Executive Officer und MD bei Dottikon Es
Holding AG, Pr=C3=A4sident und Chief Executive Officer von Dottikon Exclusi=
ve
Synthesis AG, Hairman f=C3=BCr Frugan Holding AG,
Vorstandsvorsitzender der agrocult AG und Vorstandsvorsitzender der
Cultivport AG (beide sind
Tochtergesellschaften der Frugan Holding AG) und Pr=C3=A4sident der Evolma
Holding AG.
Ich habe promoviert und mache derzeit einen Bachelor-Abschluss
von der Eidgen=C3=B6ssischen Technischen Hochschule. Ich habe beschlossen, =
aufzugeben
Jedes Jahr spende ich 25 Prozent meines Privatverm=C3=B6gens f=C3=BCr wohlt=
=C3=A4tige
Zwecke und an die Armen
seit dem Ausbruch der globalen Pandemie, die viele zu Verlusten gef=C3=BChr=
t hat
ihren Job und viele L=C3=A4nder versuchen immer noch, sich zu erholen. Ich
und meine Familie
Ich habe zugestimmt, 25 % meines Privatverm=C3=B6gens an Einzelpersonen aus=
zugeben
Jahr 2023 aus dem Gewinn meines Unternehmens, um zur Reduzierung des
Hochs beizutragen
Armutsquote, die durch diese globale Pandemie und die anhaltende verursacht=
 wird
Krieg zwischen Russland und der Ukraine, der viele L=C3=A4nder betroffen
hat. Also habe ich
beschlossen, 1.000.000,00 Euro an Sie zu spenden. Kontaktieren Sie
mich noch heute auf meinem
Pers=C3=B6nliche E-Mail: markusblocher3@gmail.com. mit Ihrem
Spendencode: EGIP/EWU2023/28392.
Sie k=C3=B6nnen auch =C3=BCber den folgenden Link mehr =C3=BCber mich lesen=
:
https://en.wikipedia.org/wiki/Markus_Blocher.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Dies ist noch einmal Ihr Spendencode: EGIP/EWU2023/28392.
Bitte antworten Sie mit dem SPENDENCODE auf meine pers=C3=B6nliche E-Mail:
markusblocher3@gmail.com.
  Wir hoffen, Sie und Ihre Familie mit dieser Spende gl=C3=BCcklich zu mach=
en.
Um zu best=C3=A4tigen und sicherzustellen, dass dies 100 % legitim und echt
ist. Besuchen Sie mich bitte
Verifizierte Google-Seite zur Best=C3=A4tigung und um mehr =C3=BCber mich z=
u erfahren:
https://www.bloomberg.com/profile/person/6131291?leadSource=3Duverify%20wal=
l,
Mit freundlichen Gr=C3=BC=C3=9Fen.
Markus Christoph Blocher, Pr=C3=A4sident/CEO/Gesch=C3=A4ftsf=C3=BChrer, Dot=
tikon ES
Holding AG.
