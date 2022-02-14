Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402AA4B40F8
	for <lists+linux-scsi@lfdr.de>; Mon, 14 Feb 2022 05:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236618AbiBNEtw (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 13 Feb 2022 23:49:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbiBNEtv (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 13 Feb 2022 23:49:51 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F13050463
        for <linux-scsi@vger.kernel.org>; Sun, 13 Feb 2022 20:49:45 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id bs32so13509971qkb.1
        for <linux-scsi@vger.kernel.org>; Sun, 13 Feb 2022 20:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=N9tEFmJ5EUuxB+3+X+96jFuGp4B/wZQHGYlWHIoC8HU=;
        b=dylpLAQQHf4R5x9fca3xOJBmjS+ovXfbmdTiJ5zQBSB++gWxFBT9WsLgQhkSlMjqyP
         u4In3qRszndWEezoAPWukWygZD1Z3Ta2oukVVvNyFNU4i5NAGpkEv4w8q0Hw2CdOnDHc
         4m+/R3O3c2wqzH3b6y/m9/uGuer0g7swCoCoGAtSBdDQ17QtRvVQqHgtfxZM/CgqqhWj
         urc6J+g7BK8s6uSTw6rKRgOxhQ636dr6s3dNyVCwpAyMs8zW9MqOPTGjBejjt6UgAeVu
         3dFuxD9OOql3v7bdEOTc1qFVyO+dVuSGMzj5x+Ry/leN8rX42bL30cg6w4+HMaLaqJ6J
         KHSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=N9tEFmJ5EUuxB+3+X+96jFuGp4B/wZQHGYlWHIoC8HU=;
        b=DTGfeMyric5Vp5q48fSj1XhxbEjqGMbNTyattLew5srsgWxUBmHJSY/w2choBk7o33
         Uf9koBjX/GK30CdmxO2S1GrxKV1yWVgLtQ0VDhickgDmnwh5if1lKq6IZIA3HGu4Cju1
         J7sIYmS1wuOrgU/vGvouDIORq/lnhflLcsEaWJ7dXprwInSRI53dA12eHkJEIaYVz3xy
         VtLEShWmLGT4LZ5DLt3kGVl58I6PUGgTN7I9jqndFeZjra7yNXcIlO7pz4H/hkZjYGEq
         1sagZQIGc7upfuy8AiO8tqd1GNUh1VVoqgtI831WQrfYna50IEzyaG6yhqmKO7CKWWjj
         aKXA==
X-Gm-Message-State: AOAM532hcYYT20FQ5f7j34hyu04yf0Gq0KJNK5giLnyDiW0XddDA9H2m
        Y04+Zr6nCLTkc8PPy8Bh3MNcP8A3aeKvxWyMfzQ=
X-Google-Smtp-Source: ABdhPJzo0rbYxGnR//E36ICtkzRLRJKLTZk7KVe/8eZbXrwwtLxh1I5rVcD09Rx4MLGdyWoKdwc+dN5l7iCjQ/MBCpc=
X-Received: by 2002:a37:a409:: with SMTP id n9mr6081735qke.120.1644814184291;
 Sun, 13 Feb 2022 20:49:44 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ad4:5c69:0:0:0:0:0 with HTTP; Sun, 13 Feb 2022 20:49:44
 -0800 (PST)
Reply-To: tiffanywiffany@gmx.com
From:   Tiffany Wiffany <ivanroberti284@gmail.com>
Date:   Sun, 13 Feb 2022 20:49:44 -0800
Message-ID: <CAKp8dfoTZegEM5V1t0c9Px3a9WFqp4Pk-j_g6mY2G5-RPcqFLQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

-- 
Hello, Please with honesty did you receive our message we send to you?
