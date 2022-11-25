Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1136390C2
	for <lists+linux-scsi@lfdr.de>; Fri, 25 Nov 2022 21:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiKYUgc (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 25 Nov 2022 15:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiKYUgb (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 25 Nov 2022 15:36:31 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD5353EFF
        for <linux-scsi@vger.kernel.org>; Fri, 25 Nov 2022 12:36:30 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id w26-20020a056830061a00b0066c320f5b49so3323215oti.5
        for <linux-scsi@vger.kernel.org>; Fri, 25 Nov 2022 12:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TIhxpAqsxiwWwE4zx+/0K3DHs1igYNY8HnTilbOLRvQ=;
        b=g0OJBX/L46Fe16Lu8zEyu6xd6xSVHHfq97nQNKYrqummezPA2qp8gg/t8N8ArDaTO7
         Hwd4m3Vxq6TQMU2UwAnGx2P5nnedyCs6mjYmUbkRRLERZyLWiOU4mg8fbqxjPRan98tp
         NBo1+ZD3gOZ3OQ10sA5JlhQ37oKvPtuf9CbFCLp6711KxhITVWtlRgooXlIedFsSFDbm
         1IKn2t0f71/AQLNcDxX/bRK7+Ap6BrgRJcsDDpC8S9Owzy0TNB6IuCNxp8fWOoscfxst
         /VomOB9HJo5ReVT2k+enfrXlsFjif3BLzC0XRYRsX1/3tQEjAHr1qR1T/RVRz97MosDD
         YNCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TIhxpAqsxiwWwE4zx+/0K3DHs1igYNY8HnTilbOLRvQ=;
        b=aAqP4Czu62qsRCXsxmlXs8X6mA52ElsSVHr3Cq82vsZY3qa1oyMoTKi8maCRt2UINN
         mRdrpx+HlxbPognLCr3Eg0FdJyjPQp91uRMnyJNQXxCh2ZE+uSXL0POs6Gq7SGlhTumq
         DXchVmWcbratLz1p0fxsEPyRhYTaxqnnQ9DHviyT8pLmY+4kndRHWfpu5b6JZ0HcXk8T
         LuDO4o1u/rZ3G+tYFTmrJIweQYc1KbTlSrGMFHiwbd0/fV/6y3w6RyhC3ya7K6pBT9Rm
         SI6XQ9fTGfdSWcLf4G3NMsolW062D+vxzAWPOHEPzJ/2M7uCogcXMSUL6fyR5VIHO5lw
         M2nw==
X-Gm-Message-State: ANoB5pkbe87H2j+3KrAXXmWw3qr8jgGSt57aOrFTmXtMa9iqZAgPgq1q
        NG4SwOgaUnsMf2I7I6/ZT9iFEw9Wdag8fgHfoQ8=
X-Google-Smtp-Source: AA0mqf7ChN5JGkIbDRjjvhf/QWBnxvtlwy5i8FG4PXziqxNpBN3InPngiVtC0CDPairmZ/7G3eX1kLqe+tA1UehCZqw=
X-Received: by 2002:a05:6830:13c9:b0:66c:a3a8:3870 with SMTP id
 e9-20020a05683013c900b0066ca3a83870mr10819424otq.54.1669408590110; Fri, 25
 Nov 2022 12:36:30 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6840:6697:b0:faf:e552:8c5b with HTTP; Fri, 25 Nov 2022
 12:36:29 -0800 (PST)
Reply-To: privatemails254@gmail.com
From:   MS NADAGE LASSOU <hunhdd123@gmail.com>
Date:   Fri, 25 Nov 2022 21:36:29 +0100
Message-ID: <CA+9ouuqv2H=MoGCOvhsf_R2wTjr1sgutqb+QjhbyHF8SEMwLWg@mail.gmail.com>
Subject: REPLY IMMEDIATELLY
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,UNDISC_FREEM
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:343 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [privatemails254[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [hunhdd123[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [hunhdd123[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Greetings.

I am Ms Nadage Lassou, I have a important =C2=A0business =C2=A0to discuss w=
ith you,
Thanks for your time and =C2=A0Attention.i will send you the details once i
hear from you.

Regards.
Ms Nadage Lassou
