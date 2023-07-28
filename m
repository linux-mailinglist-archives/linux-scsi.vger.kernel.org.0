Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CA076721A
	for <lists+linux-scsi@lfdr.de>; Fri, 28 Jul 2023 18:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjG1Qml (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 28 Jul 2023 12:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjG1Qme (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 28 Jul 2023 12:42:34 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996E319A4
        for <linux-scsi@vger.kernel.org>; Fri, 28 Jul 2023 09:42:33 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-686b9920362so1727788b3a.1
        for <linux-scsi@vger.kernel.org>; Fri, 28 Jul 2023 09:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690562553; x=1691167353;
        h=subject:from:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Yhlhj93hxWvTBueKrHA3zytToTRDDR3HTuZBK/cEF0=;
        b=H3d46kB46VtgOssXGvOXJYoLWtqrZttNFKKN4Oe2vCCjRq7WhFJShGhZi0AwWzBTIB
         rd49S3wJY0AZdjmrJ/8qlgQ2V9VoAwdNMYX5tBMBDVB4qtQWApJHVla7Ey4E7GTVTJvQ
         8ySPYKltwzKPMBxSrc5pcl/pw4La5ihdm7+xeRep+gSHdvBcifpO3EdjeQgpC/h48CUQ
         ApdBbRcGiWFimgkCHG+rlsLp5HgnFKMsD5DTQUkE5zKZenBnKP53P4Koxw/SOGmcDwNU
         ANnZzy4V/VZYLFDTJdj8uC+we6Vqm7LfQc+tuV4vj9f9Ch/aalyGTHehOazw/4UEvmgO
         Jrew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690562553; x=1691167353;
        h=subject:from:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7Yhlhj93hxWvTBueKrHA3zytToTRDDR3HTuZBK/cEF0=;
        b=SBGDF0mEHbpU5yJa2ClpyzS2igWLarbVGYHA/aB6lLPwptI4CEMCZVdpbZ0Cax9QTf
         OsgFPTpo2e6jOCOFeLsEMiuNwv7zvSyIrqYrfADinUbH3VkD89DL5A3kUL17A8lraDdw
         SxkJ7KtPBNxEbk/0c3uTjLxJUByO58xRCRTTmxaRp8x0SRPwRt2tEzhSzefNWVg84JzA
         cG/bijRRNXex3XVrIkC01bFkExkzrc8y1WeLi/QCy3Rn+FDijt9d+gC9B1F6Zaun9xse
         vkubmo+fqOYaPmeULsRDLmL5iykOgNPvJ6ST2Cx/PJp7sHZkViPSOYGi7lNw/RkJDE99
         VM6w==
X-Gm-Message-State: ABy/qLZnVddIw8GntTyX63JdDGuWAQKUvypfbRcHJHahbCpaMo77w5QV
        0/9LK1p854qBuJVZVZaU2hHcZDWxns8=
X-Google-Smtp-Source: APBJJlHHFzAW78IIl0sWvJ5LHEk3FHjzauOrZC/ucHJwd27kXeKzHU2zk/RPrjlVusTd/ge3nfuohg==
X-Received: by 2002:a05:6a21:2782:b0:130:7803:57bd with SMTP id rn2-20020a056a21278200b00130780357bdmr1735615pzb.3.1690562552963;
        Fri, 28 Jul 2023 09:42:32 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([2001:288:442d:1:b924:ef7d:94c:b7a5])
        by smtp.gmail.com with ESMTPSA id x25-20020a62fb19000000b006687b4f2044sm3398263pfm.164.2023.07.28.09.42.32
        for <linux-scsi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 09:42:32 -0700 (PDT)
Message-ID: <64c3eff8.620a0220.78363.6a8e@mx.google.com>
Date:   Fri, 28 Jul 2023 09:42:32 -0700 (PDT)
From:   chatchunsearch@gmail.com
Subject: danny! - Increase Customer Engagement with Chatchun - Your Website's Chat Solution
X-Spam-Status: No, score=1.8 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        MISSING_HEADERS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Dear danny,

I'm excited to introduce you to Chatchun, a robust live chat service widget designed to enhance customer engagement and support on your website.

If you're interested in discovering how Chatchun can benefit your organization, don't hesitate to reach out to us at chatchunreach@gmail.com. We're available to answer any questions you might have or provide a personalized demonstration.

Best regards,
Albert
Chatchun

Website: https://chatchun.com/
