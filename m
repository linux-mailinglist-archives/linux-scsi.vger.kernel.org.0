Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B765FD45F
	for <lists+linux-scsi@lfdr.de>; Thu, 13 Oct 2022 07:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiJMF5r (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 13 Oct 2022 01:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiJMF5g (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 13 Oct 2022 01:57:36 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5D0129776
        for <linux-scsi@vger.kernel.org>; Wed, 12 Oct 2022 22:57:35 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id g28so1028276pfk.8
        for <linux-scsi@vger.kernel.org>; Wed, 12 Oct 2022 22:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=huYKu3zCGUAjNe1V+fwzWUibgp5qt9T7Bp033OSK+pw=;
        b=cankLalVl+oTUze4fEh3M4cDIxIMO244kfrzjwLUyK+LqPtqtrD5F7szBxl4p0oE9D
         DRStNBhV/GgdIwXX0qMxP3ZxPgp2VfNY64xZiHXBtxOlGDs34jciNoerCqgCp1bgZm+1
         +6Ti/fpmZDYHFwj7mBsy2wo1nWnxpmKXYimL94fx3m4H1u2nV/z5OZf478OxNvJmRFno
         57Q2wxhaocNM3ox7SlrsdC4SyLGGfXTOQmWvHHx0I70U8W+dHZYeKRDc+txye7b8dQV/
         kpOgrBFvvaeQR2EGDTgETbtDRNeEZHp0vrBvuLt1S3p/q9Q61rPSP6HLf5Bq+ysIE+m7
         gtAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=huYKu3zCGUAjNe1V+fwzWUibgp5qt9T7Bp033OSK+pw=;
        b=wzlBsAWTaOtj2SOwgTSQ4zHJzZR4NKdGU6Amkx5Lf3SiX9FoYsSmEPo8KD4LyEwSNZ
         +LjBv0osTDvnJlYlGO1HUobANNclQxJqMbKNWEfonAC9bu5xtZHR7abwVrF/4hiBehIi
         Ni4mAzz0+YytFw3p6K5WFy4/awnZIARyitOZT+wZntPX/0PWOWHoTBL0HKHQpWr3+PMK
         Rl7TyDj1uP6hf0S0aMWgrKfGO9RJPT+JefwqqXjJu590voCN+O22/9ssqVsvZWcSV9XO
         UxNYxih4WRwRfTKAR5NAwbpXr74azq2/3+4T/0nW3/7N8UkyzcYj0YKX6QZ2dL4hiDuG
         3VAw==
X-Gm-Message-State: ACrzQf11c62/o+vOCVEz9pPSABOwyBR9VZOujF61te326oUYEWX2Y9z9
        5iFB8diS2UrV4sqZ3cU6tri5FL49POAqPki00ZM=
X-Google-Smtp-Source: AMsMyM6XVztMlC2gldFAm8tD3791LrLUhbvVJsTTUtTrJ8FdX8zt9GenVNHllFpteg6utEmxMyAIJVN/Jnpj9OwOaBw=
X-Received: by 2002:a65:6cc7:0:b0:42a:4d40:8dc1 with SMTP id
 g7-20020a656cc7000000b0042a4d408dc1mr28907178pgw.321.1665640655249; Wed, 12
 Oct 2022 22:57:35 -0700 (PDT)
MIME-Version: 1.0
Sender: zjefftwilliams1@gmail.com
Received: by 2002:a05:7300:18a7:b0:77:6573:124 with HTTP; Wed, 12 Oct 2022
 22:57:34 -0700 (PDT)
From:   Pavillion Tchi <tchipavillion7@gmail.com>
Date:   Thu, 13 Oct 2022 05:57:34 +0000
X-Google-Sender-Auth: ECjvfJPVSckDSJFUhz-kxggv1kk
Message-ID: <CAHfYO7q1=yuGPSGnbst=vYMNC2RN8NTFcPpXgux8-nzA948WpQ@mail.gmail.com>
Subject: Hallo
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

-- 
Hallo
Erhalten Sie meine vorherige E-Mail?
