Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E36B5746E4
	for <lists+linux-scsi@lfdr.de>; Thu, 14 Jul 2022 10:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbiGNIgn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 14 Jul 2022 04:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235779AbiGNIgm (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 14 Jul 2022 04:36:42 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1013ED45
        for <linux-scsi@vger.kernel.org>; Thu, 14 Jul 2022 01:36:40 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id t1so1625868lft.8
        for <linux-scsi@vger.kernel.org>; Thu, 14 Jul 2022 01:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=H3bGT1ZyGPu3PRQJlJHyQI9TvTjBPuNSyHjFOzNfiP0=;
        b=nfF93HFABydKtKUN6hm08YjvNRh2G4i7biDP0iGWKm0CJI/6tO/7ASVGiMVbrFcvre
         dFe7LS0o6XmnC1olR6EZQT61Pk5CcDXk8EOCE/ZUPQPC2WOF08wHjQNTI98f51BXkTW7
         5dyslKzFlMJ1FAFUBcS5XSZMuJJQc0mVGS8sJL1EcuApFLh9MbSY3DeHMChVpm6lylO2
         ZiD2YD5TYnCnW1RYesj2zabgr2TZokupGOdRW5Wg1Wsic5Yzi6a7GNVAIH/aFq924Tv4
         l/BLkapdJUQdDh1nnfELCxBLwNTsd2zSHh12MGEWr6e9uOYA2kL+ohlW7KhzBK2CbHvs
         dAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=H3bGT1ZyGPu3PRQJlJHyQI9TvTjBPuNSyHjFOzNfiP0=;
        b=7r2V2hJeDNv+8KLoCfzzv8Ot5yEiPSqAVkJ4iLmftzsCMWONIRc6hCTvBtzEI0IxdD
         L1Cpvz1qLDDHAbd1LtfRsGLDn700nu+ssu6zZli/2yxFtImvH1/GXOlcDqxSVsV7pQFl
         VD7gfdpI2RHZ4Kb73pn9nYa8VUyMkGUq574NE/TDanC7XHucaqPdvNB/zsuVGKMXXGlI
         Vz+CxGEEZLS59PikpAgj+BHGgdlYUkKFPTYmxn59mgKgdsm99fcZK6goQHObKl8cG8Ni
         pGKhkzOH/ERTMwptk5jewSVrSP2SBMFF//dDOYIFbyAtCpt+6UgkWvKJT+r5N/IjpRfy
         yiWQ==
X-Gm-Message-State: AJIora8UMfGu+TeSK+6w6GQdgK4W+3vjL8I71XRRT0MGH4x3w4nUWg/O
        dMn7hjrD9ehDRLhpAkDBIsc8hrYddiak4TFkITs=
X-Google-Smtp-Source: AGRyM1sBAY02anFyAAkYvB61573ohyB+lIVHvdune1I2St249pttaSZdeqZISv5rckThyg5u7Q/retQg6yCpkFrJ9YI=
X-Received: by 2002:a05:6512:1307:b0:47f:baa4:52c5 with SMTP id
 x7-20020a056512130700b0047fbaa452c5mr4350443lfu.103.1657787798421; Thu, 14
 Jul 2022 01:36:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:9041:0:0:0:0:0 with HTTP; Thu, 14 Jul 2022 01:36:37
 -0700 (PDT)
Reply-To: abdwabbomaddahm@gmail.com
From:   Abdwabbo Maddah <abdwabbomaddah746@gmail.com>
Date:   Thu, 14 Jul 2022 09:36:37 +0100
Message-ID: <CAFC-3idDfFB0Mmtq-N-n6z5Ly7T-KDCJtvbc0UgtirMnTLYTCg@mail.gmail.com>
Subject: Get back to me... URGENT
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:135 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [abdwabbomaddah746[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [abdwabbomaddah746[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

-- 
Dear,
I had sent you a mail but i don't think you received it that's why am
writing you again.It is important you get back to me as soon as you
can.
Abd-Wabbo Maddah
