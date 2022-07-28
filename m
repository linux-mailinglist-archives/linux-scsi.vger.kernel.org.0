Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADAEC584114
	for <lists+linux-scsi@lfdr.de>; Thu, 28 Jul 2022 16:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbiG1O1Z (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 28 Jul 2022 10:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbiG1O1W (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 28 Jul 2022 10:27:22 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA50866121
        for <linux-scsi@vger.kernel.org>; Thu, 28 Jul 2022 07:27:20 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id o14-20020a17090a4b4e00b001f2f2b61be5so2321232pjl.4
        for <linux-scsi@vger.kernel.org>; Thu, 28 Jul 2022 07:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=kCSqCOP5NnmgqzMKAvoC+xj8lkHVueu0SPSEqGKA1Ew=;
        b=RFZCtUK3cvikmbUS0W0W4UHXT+HuJ9ODz2YLvYQ8kbAp7R4aVF7DCghAh2wCwzeDdU
         edbAKFjnDG5vWPiEGr6wqSnW/r7Q9YrQIRvWoSrCtqSgPKmq2ZxFKNPf5m9UwLlJZO4q
         P5Q9wtYyli0jnvf11ytLsKxlfuarn4wrC9ZqhoSyN5P6LWEBQ1k5yAAQfdWVcWCNJFd0
         e2M4IB+R7IbZXCdkJKtx1EGi5NkjQSSuw9d2cG5lbPrYWYz64QGbyg0XSrF1LS4mjESx
         2khddqKQR8oiATtv0KsJ5yyWCYhy6zL/jMrRPERadAzyqkDYNXQa4uh4bAwR7tldcDxY
         ESnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=kCSqCOP5NnmgqzMKAvoC+xj8lkHVueu0SPSEqGKA1Ew=;
        b=cIUG3cq9GGcdeLr5BCBvvGAb1+N84t4ncFdrbIRcZFaMp3Gp8aBybQ9xjEXpdaZXnv
         M5HsoQB/QbZGyKwYwO5dVgIZ75Mc2cIP75FO8ILBNmg5BfIFiVUClQZ8sKttD493OrmY
         CQuH6sXsM1IoZILq4uCBmQ01iFH2b7srOcZk/rqtu55Gl3+1YQKNFS8oheES8kSLXfOb
         8VMybB5JGDr2qCFKs9blv1nAWdNvrgIL8bwMU6bpawVuvdkHhszGQ+VBnudz2jLSRf7U
         q11u4DCmZdGEDCOvs+95GE16djocL8u3u7/2LFISP87FW/hJgIuqSKZh0clUqD7PqHA+
         Fp2w==
X-Gm-Message-State: AJIora89F8l/jhS2VZBTI2OlenI8KX7ORK8qiF7Zm3n2ykU0Y8VUeHtS
        kTtmUhmJLAISUg/FZ5JQgla+TcRooouUVHUldLg=
X-Google-Smtp-Source: AGRyM1uRTmdF1kPPxZ3WFxx91EHa4GmUfC6kM+AQx6r7JwkJF/cJdhLGpq2A7YyWA5hm2jgphlUx7pb5CJrRfRLLlhA=
X-Received: by 2002:a17:90b:38cf:b0:1f2:fb9c:6003 with SMTP id
 nn15-20020a17090b38cf00b001f2fb9c6003mr10465113pjb.214.1659018440122; Thu, 28
 Jul 2022 07:27:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:678e:0:0:0:0 with HTTP; Thu, 28 Jul 2022 07:27:19
 -0700 (PDT)
Reply-To: lisarobinsongift02@gmail.com
From:   Lisa Robinson <benjaminkitavi49@gmail.com>
Date:   Thu, 28 Jul 2022 17:27:19 +0300
Message-ID: <CAEwLOJVMBvZLq1OURgjjQWCGEmWNPFow6=T0BP1_e40Ga=C_JQ@mail.gmail.com>
Subject: Donation
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1042 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5027]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [benjaminkitavi49[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [lisarobinsongift02[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [benjaminkitavi49[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

--=20
You were chosen by God to receive my Grant Donation of 1.200.000,00 =E2=82=
=AC
Please contact: Mrs Lisa Robinson via email:
lisarobinsongift02@gmail.com
Surname:
Country:
WhatsApp phone number:
