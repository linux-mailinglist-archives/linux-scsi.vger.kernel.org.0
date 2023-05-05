Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAE46F8057
	for <lists+linux-scsi@lfdr.de>; Fri,  5 May 2023 11:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbjEEJso (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 5 May 2023 05:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjEEJsg (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 5 May 2023 05:48:36 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D0B19936
        for <linux-scsi@vger.kernel.org>; Fri,  5 May 2023 02:48:28 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id af79cd13be357-74fbf99adc2so67268485a.3
        for <linux-scsi@vger.kernel.org>; Fri, 05 May 2023 02:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683280107; x=1685872107;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MFG1KNlvf1Axxy9iiCRuF2Wv9mzsHvQM12J2RA1vN6Q=;
        b=fJzWOHnqtVxlrWcvLkxqRGarsb9pr2QrY0Jrv9Wx3k3NxzSEJ2lZ94r66xs6Y/N2ry
         5e+RSNx1WzmJ6sg/syA7zxkKTYeO278gGR5SUbh4ax+Rh18iuE6V3FEWVSSu7ikcwlMA
         oOVtbeCtbZzYCYcAOuQRIEncM6SXAMyFcASWwyTvixyegzFS6tiQKMqrMDNLszlNh3kJ
         ia/JnSkwONojZMfFowEWARnu4qPssfx6i4YvdYHGleK1CCgO4XUpSQIQIJbhEECMOhTf
         WGE3CYJ2UjCShqBHIqiANBum1HDeyyNt0UN/YGnQXCkqO8fIy8FbxkGv/iPHR+JH8+Ay
         F3bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683280107; x=1685872107;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MFG1KNlvf1Axxy9iiCRuF2Wv9mzsHvQM12J2RA1vN6Q=;
        b=U2nyBzju/xkEGPtPC5Kpca4QEf4i+5WJ+s1MksxrT7TQtO2hdjmu6vF6ixFfXbR/2t
         OThOJxtt2aW0nKLYgekyadMrzCNgmwSToeFoCd1zsm8c5CX5acEwxdqQ+2hZ9M3CknoS
         /1qKbddsloMInLExUUblxZtkE8gVWOaQpaWYLWD0rYQxdKOpX/dJX6xqcWbaHd2QpAOV
         x3gwNRN0TlqmOW9gAOaZ0GQVs/4aXN2L6isaJaGb1BfQ5IXzTKsF9QAktRPwm5/e/GwO
         h7aEF0BZuV5wBizPWDEB7uCqCcM+OMSJCl62kly8k2wGd2bfApesIUxl5vgKyvlU2HuE
         S9xw==
X-Gm-Message-State: AC+VfDy/+G3DxsHjZro8Rhqk/zVXUSjmlftsAjh8nvx3DVcGukKd88xL
        T46peWf2CrqQTXRaK0QUCdqnuAVHA/+JZ/0xRFE=
X-Google-Smtp-Source: ACHHUZ66bqyCJ3lPilgel0p6T0TsqfwnwHbphiLK8KBs4adNaRspwJz9GJu5L9uqYtm4VuQtcsyhdwULqhp8G2MLxkw=
X-Received: by 2002:a05:6214:d04:b0:61a:d6af:cb00 with SMTP id
 4-20020a0562140d0400b0061ad6afcb00mr1048488qvh.9.1683280107112; Fri, 05 May
 2023 02:48:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:8b81:0:b0:5e9:aa07:4602 with HTTP; Fri, 5 May 2023
 02:48:26 -0700 (PDT)
Reply-To: lschantal86@gmail.com
From:   "L.S Chantal" <okorita23@gmail.com>
Date:   Fri, 5 May 2023 09:48:26 +0000
Message-ID: <CAAOeSbRfoPozaiutacs7mQT4coJt2=2+orwinUJ_FCNprTA_Bw@mail.gmail.com>
Subject: hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,HK_SCAM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:742 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [okorita23[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [okorita23[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [lschantal86[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  1.5 HK_SCAM No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.8 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

SANTANDER BANK COMPENSATION UNIT, IN AFFILIATION WITH THE UNITED NATION.
Your compensation fund of =E2=82=AC5.1 million is ready for payment
contact me for more details.

Thanks
