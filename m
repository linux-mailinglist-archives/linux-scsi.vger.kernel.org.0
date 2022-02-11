Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72814B2491
	for <lists+linux-scsi@lfdr.de>; Fri, 11 Feb 2022 12:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345246AbiBKLjK (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 11 Feb 2022 06:39:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbiBKLjJ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 11 Feb 2022 06:39:09 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7F2381
        for <linux-scsi@vger.kernel.org>; Fri, 11 Feb 2022 03:39:08 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id l14so8733915qtp.7
        for <linux-scsi@vger.kernel.org>; Fri, 11 Feb 2022 03:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=t4j9Rb16aPvVbRhuxKGxLsBlg7Gmzbg2zGYIdPTYmXw=;
        b=HiSgNcF8D+E4i/QviSzN4aynWNtLk/eHKgN24mtnPsL24vcu5AWEeG5bAeiSiQqWFN
         HXkgkq1sNG6nvUnBh0u6le0y6MlAukQ6Lx1TYu2p72c7YbfwPL2kXKGtCHt1R9THsLho
         sC6/xigZP9fZp8yf46pwpWjSfgdaruNb3UoXrXCrZoOFlKhoYRvQTLl1uteCoHlvcqnc
         r6+Tyouh1zq3AnckoV1ofhnGDIF+5GXGK3wGrQMv5WXif3n9BoDtQLw9eKVazDAeOU9L
         zccEn8heicCm65oztqZOx4g5+CYJfLlz0caUuqukRhoyTfQIXhxJAJQyRldVJcJHnN+T
         mhBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=t4j9Rb16aPvVbRhuxKGxLsBlg7Gmzbg2zGYIdPTYmXw=;
        b=DwjXC8ghXPH0y9KqUiai06b1woO5CuhAqciItr68RKLqL6NVQL97IkbcThbRtRl8Rp
         fVGP2YoNZC8Ko6kLXUNxftlhA8XZGIQIs8cOclPFlJXKNMjbVNHUbEySDTj/RyWdJQqq
         WM+VpLapGvgjXJwF9ZbgagYxzx5HZiwkUckGSmcCENbxoW6jc+bqAajlNw+cfpuVowGU
         k0UeSmmO848Ft9oZOZXgUJz0uCG3eHwthFv1x/2i5tvQZBvypRnTV0w+IGz9ySUOdi9i
         oatU9gVxyAkBtCr3OcV5Zu5KLKQVbLI1PjT4sQ1GXPS7SvRoE3XXvdsAMrz8ry+y1NHX
         O3eA==
X-Gm-Message-State: AOAM530LhPaGgw4aol8PXp1ts5vxjLCELVZhwsdHyvAk4agl73qndymA
        WvbxlGWAHsRPbc90aN07nqS1SI/p27k8ffmzGw/guHPMZllSRzey
X-Google-Smtp-Source: ABdhPJyaDhH0qKchuvfvktc+mNZLosxBH2SgLZUkyQs4/ZhQDhdZrgkZR6rVKmtHUwNsanUOcp05S6DfkBIvSVwXl4I=
X-Received: by 2002:ac8:5b94:: with SMTP id a20mr730058qta.270.1644579548032;
 Fri, 11 Feb 2022 03:39:08 -0800 (PST)
MIME-Version: 1.0
From:   Du Dengke <pinganddu90@gmail.com>
Date:   Fri, 11 Feb 2022 19:38:57 +0800
Message-ID: <CAKHP1dtAOsHQ=Q18A+hm6a7XWHQPXV053Kb_E2AeneoWCVzBew@mail.gmail.com>
Subject: 
To:     linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        TVD_SPACE_RATIO,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

unsubscribe linux-scsi
