Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E22E69312F
	for <lists+linux-scsi@lfdr.de>; Sat, 11 Feb 2023 14:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjBKNOW (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 11 Feb 2023 08:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjBKNOU (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 11 Feb 2023 08:14:20 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687C22BEC0
        for <linux-scsi@vger.kernel.org>; Sat, 11 Feb 2023 05:14:19 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-16a7f5b6882so10045247fac.10
        for <linux-scsi@vger.kernel.org>; Sat, 11 Feb 2023 05:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QwJ3djsgu7EpFGFjesrarL0td1XXwZi3NukCRezNELs=;
        b=X67rhwgFDy1DbH6IkfFXA+F3E4p//JoQLDDMcwZCEyhBWYkKSjilHIxAKSRd8xAQ6u
         6m+IomfZdh03VZTC44Qb+lWdcLQbqP3iJoMZDfEDon+XjHyeC36S8m1/UTutYTlOQeKS
         ZdDKctCk6OTX39nI4V4KZqRbMdp/+AjPpPDdi3sG0c2mQE21N+SeWkgnVdUYdi1L9KYn
         7rEC8dx7ljB3MxXvBbTT5VH/5+Unk/Ra2vRicklT1kZ56y6qr5EtAEp31nR1MjXJ6skB
         UpDiV+4d6Fe6riSgSFiLzl0o225/nYEh/MZqnmSx5SnWPq21otyzjCcSpbrKqj9FKO9c
         kz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QwJ3djsgu7EpFGFjesrarL0td1XXwZi3NukCRezNELs=;
        b=E31w2B3gA+L/id+mPSR9m7GQ/tNg2rEon2axkYQSnmRTICgv9hjJjKfm4QNtAdEahi
         OLVK+7vZ5ZTzpqcxWn5xQ6DWpc1/Wx6uPhxjHDVevyVmaNm0hZCgrpFrZqgHFAJUx+gQ
         JVzuavINHtQ8XBJZ+HkcL4of+wOSw+evPhs98+hqcEMR3P5qlx41y75ZZigdGnHHaAS+
         mNMw5viyMyaFE0gXXt+JkVdFwYIBcA0vK3J5zJ50jdHagmlWL+5JmXRQcP3hFh8EfJAu
         NHRUdh0ClhfL0KOYbfLwI4gznR6JMn3du2e78d63WotF1Hs5xY18PPIowCpDTRC1mgAr
         BQtA==
X-Gm-Message-State: AO0yUKXZUzvz1QIF/OG3BVhQO2a1YkO3HMXJOUXLjVm25eyzJzbfUxxp
        pYTyQm/LGlaTyN2/pVYrUvPWHqFhSBs3raraCZ8=
X-Google-Smtp-Source: AK7set8dzqAbRgaOJUyNJgW6jGnRaoIR6fcEPxE89eTK/TJ4le1HcoR3x+976frd2pQi+tH526zWnAWTU3yMMyJ3ISI=
X-Received: by 2002:a05:6870:c38d:b0:163:1d19:7d7c with SMTP id
 g13-20020a056870c38d00b001631d197d7cmr2730918oao.64.1676121258533; Sat, 11
 Feb 2023 05:14:18 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac9:478b:0:b0:4b9:3092:ef6f with HTTP; Sat, 11 Feb 2023
 05:14:18 -0800 (PST)
Reply-To: lassounadage5@gmail.com
From:   MS NADAGE LASSOU <nadagalassou3@gmail.com>
Date:   Sat, 11 Feb 2023 14:14:18 +0100
Message-ID: <CAAPPVT0LfnLSBTttr75=Nw6KP-6GHvhMEZSXFXZzheyNO6Bk4Q@mail.gmail.com>
Subject: YOUR URGENT ATTENTION
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,SUBJ_ATTENTION,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2001:4860:4864:20:0:0:0:33 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [nadagalassou3[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [lassounadage5[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [nadagalassou3[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.5 SUBJ_ATTENTION ATTENTION in Subject
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

I am Ms Nadage lassou,I have something important to tell you
Thanks, i will send you the details once i hear from you.
Regards.
Ms Nadage Lassou
