Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50125E8D42
	for <lists+linux-scsi@lfdr.de>; Sat, 24 Sep 2022 16:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbiIXOVK (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 24 Sep 2022 10:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiIXOVJ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 24 Sep 2022 10:21:09 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10F231344
        for <linux-scsi@vger.kernel.org>; Sat, 24 Sep 2022 07:21:05 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id a5-20020a17090aa50500b002008eeb040eso9496149pjq.1
        for <linux-scsi@vger.kernel.org>; Sat, 24 Sep 2022 07:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=AcvpqKQjMpRplqFVZebfcgNLolXN3I2DgVlaq0brtP/AnQf7TzzIei0+EF5LKarKpZ
         V7a4ez4DV1yKV+73b9vzoAvCC8w5L3YiqeBV608O3QBc0w0+o14NdFQ2aG1W7Yf4VNxs
         2htKGes5z43CMg0ag3NKDgPhu4oIJLZG1RuwZKo1kZoIITLCUJuduleb8wJYeo0bFL3A
         F0qEdnTuYbDUg96lrzqU9ZHEPlekSxsHj7cDJ6ZGh+6+WtsmIKOuFAS+tkiOI/nx/YDV
         oIESsNuxa/VKtPBHxiSKiqbz3SBj41zfuaFcnVxhjvRuoCsVUxQzrPe4otf0sRuk/jWc
         H6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=rxTytM2PrYQSx6EJOTIZ3iy6EbK/7/ID8SMeYVeZ/2HXtaSi+rIKoFh/qvuommMS/z
         FNBZmX6sDGhLRVoYYXwboqUF2+N41AaHBkoJk95SbDh6c3Ikiupdix2pF5NkLrtDT9UQ
         e8At5+30phhyu1JYZOOvpPIx3erVaFWdcSEs6ZGIictE+p50ifF9EPjKXtwyupc2UgwP
         5OdA3Tl+TJq/1k99lhEEUD3G/6+xu3+cMd+MLWdgDnLMeXCIPtnP7fAOiGvowrCrVUhH
         ky90p0kVrwMUG25/HkdXw5Yu3yzRBWfKhNpAfM9pXcGvi+V8up/r+7Zh/OmLY7Oyo4Ja
         MyHg==
X-Gm-Message-State: ACrzQf36zlKCKsIb3GR39G317flGwG0ehPzcSTZAeQFvGQV1SMsQyFyj
        pHSSYeKhxvawwrTdGW3CgZYgyfWRLz73qrIEwYw=
X-Google-Smtp-Source: AMsMyM5LHzGnlbWjqaaYTQVegB5aEW4YBTIr2kHwMdQUd0KMsOrhFqAFlV6PAvzpk4etMUnpVorhhbQVNLraVeOZAWE=
X-Received: by 2002:a17:903:186:b0:178:3af4:87b3 with SMTP id
 z6-20020a170903018600b001783af487b3mr13601183plg.117.1664029264872; Sat, 24
 Sep 2022 07:21:04 -0700 (PDT)
MIME-Version: 1.0
Sender: melaniegonzales2017@gmail.com
Received: by 2002:a05:6a10:f2d4:b0:2f2:4c72:ddb9 with HTTP; Sat, 24 Sep 2022
 07:21:03 -0700 (PDT)
From:   AhilLia Lialia <mrsliaahil070@gmail.com>
Date:   Sat, 24 Sep 2022 14:21:03 +0000
X-Google-Sender-Auth: QisrulfJmt6trH_QdzIKqtqaKdA
Message-ID: <CAO8g-4tDp7d_w_V8AXZ55DvmgH7sS-x_-qpVZx5=k5BJircCoQ@mail.gmail.com>
Subject: Hello, I need your assistance in this very matter
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


