Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21C0630D32
	for <lists+linux-scsi@lfdr.de>; Sat, 19 Nov 2022 09:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbiKSIOf (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 19 Nov 2022 03:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiKSIOa (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 19 Nov 2022 03:14:30 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8D831ED8
        for <linux-scsi@vger.kernel.org>; Sat, 19 Nov 2022 00:14:29 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id b3so11765173lfv.2
        for <linux-scsi@vger.kernel.org>; Sat, 19 Nov 2022 00:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WZTiLXhneeUvnUZeYio3jKeiDHbJPOzMbcM+CqE2gcE=;
        b=p9HnG9dDX+sB3sih+Qp9I7Nx9LnWJLZS71+JQwUDw3jjNIt46hGjW4R6lHNKRExBAG
         z+pANRYpsLBbvXoAKRz49nbtumWmL98pvXm22RhqXWGzfjQFmt+JpaIfBkOSiSnk+m+F
         4Z9oZJoO56HzPnur+gfQE3sgr/gnFCuxHcaJRv/kiO5TgFSTefiBRkHa0iHjieoy/l4i
         x9OjyN4cwFYgkGuxqjQgeNwz57W99xtEf+pE0NkWQaZHda8a9+DCuPAqZ0mnOhNiE2Ch
         hXiLB5c7Gon1erLPLkeNLLOtNRCCFH3PbPTrn7eEF3k/2jDWUbNyl3bbIknDNC856vJB
         QIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WZTiLXhneeUvnUZeYio3jKeiDHbJPOzMbcM+CqE2gcE=;
        b=0pp4UktEkTxVj9AcYtRl68epcfhTl/phDZsq6XAICyKuBnhKn0jT1R9qrL3Yl5ED5g
         1G9gwqMQ+ofpknOuZU6uEtKjItHusdsjKofbDXCKp7TldGzTNm+AUC0yq2zKg35BvTpw
         IBGVJ1QtikgZXmFw4pTTNtsRj9EMmKI7auatvLbQjC+VArDbiBaiKkOdJYtAnMhpKpoV
         /KAW5NV1FqbbvP8SQOMyr1DvYDGUgH7Hi3YjgVQq/Ua+wotg3l8tQjj5rW5QwdTyLlFE
         umkvWd9G4x67MqtaA7b7oySa5eAGVIIy5uuakuNOMIEJXueVYhRIMeyXal/kQEgO/xnc
         hIkw==
X-Gm-Message-State: ANoB5plQuewD3uhk/CHDsBorwlQf6O9Ksn615RwJxKYcvJmfD6YUKFyy
        Ik8JWSgM1HfzJertqkSzb1CSU8YTUBZNL6bFjUY=
X-Google-Smtp-Source: AA0mqf5VQjRAryd6OLiGuZe7jtDIvmMVTVD5Qd+5JCa5yu+G8eLEWojNzYE8v+6KF2gtQpBn1QNghCvG76Fqk0bf7bw=
X-Received: by 2002:a05:6512:32ce:b0:4a2:676e:cf60 with SMTP id
 f14-20020a05651232ce00b004a2676ecf60mr3174071lfg.624.1668845667500; Sat, 19
 Nov 2022 00:14:27 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6520:3350:b0:22b:26fe:67c0 with HTTP; Sat, 19 Nov 2022
 00:14:26 -0800 (PST)
Reply-To: stefanopessia755@hotmail.com
From:   Stefano Pessina <susanndutah88@gmail.com>
Date:   Sat, 19 Nov 2022 11:14:26 +0300
Message-ID: <CAK1+f_iy7v-EfMk30GU0ek4KE=prjoL3An33pEDWxSKjkNdZUQ@mail.gmail.com>
Subject: =?UTF-8?B?cGVuxJvFvm7DrSBkYXI=?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:12a listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [susanndutah88[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [stefanopessia755[at]hotmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [susanndutah88[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

--=20
=C4=8C=C3=A1stkou 500 000,00 =E2=82=AC v=C3=A1m v=C4=9Bnoval STEFANO PESSIN=
A. Pro v=C3=ADce informac=C3=AD
se laskav=C4=9B vra=C5=A5te na stefanopessia755@hotmail.com
