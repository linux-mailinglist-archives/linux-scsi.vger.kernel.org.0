Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858305429F5
	for <lists+linux-scsi@lfdr.de>; Wed,  8 Jun 2022 10:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiFHIxl (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 8 Jun 2022 04:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbiFHIxB (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 8 Jun 2022 04:53:01 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340FA2A5D7A
        for <linux-scsi@vger.kernel.org>; Wed,  8 Jun 2022 01:11:54 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-3137316bb69so5978997b3.10
        for <linux-scsi@vger.kernel.org>; Wed, 08 Jun 2022 01:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=MM7XUMAvmlk6h7cE3y+LS0P/v9AIDMPXrU5uC3Bfwzw=;
        b=XVSljIgT/jBvn5goq40KAuGuPmThVjGC0GBP8nxxSeg27vrDs+d6zigU2XOBcv1s83
         286YBVXsivGphwt8J1nmGoPJ7Z6JbfCjv9VTyCFGzSHoceRJjwhj/6wvUaFLqUCnCQNJ
         X+aHVt1Rs6Vz6iBs+I37hsWrgp/qdROL5IBKCwH82iiuYZO1E9XXMwsqygdMFMPQig2Y
         uOavONWcADPmnHK1E2ujc3IUpVS8mvQ+89abYkvVrE5u0FxOA0DRMuNsera8ka33rTCB
         /w1WGf/2raUazBqCT0uVUBU5CBkOBBGClXFYNARW6sxNAV8NS5FaJzBz50lAxLWciK5g
         RFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=MM7XUMAvmlk6h7cE3y+LS0P/v9AIDMPXrU5uC3Bfwzw=;
        b=qaY3StL3sygLGkQH5Rs591zKsV1PijJmQ9Cr/lKr0niPmIObNDZ80ZCPiOwC4db7L6
         VBD5rL0wu2Et5YdpyEfYKxZmQP0FW/ZY64tndlvwpac6YPbe6pFly9/ADJDBPxnpRikg
         GQe1WuH+bbighEjeCrz0kgUoMfkdehgDQ+mwyQBlCKid+meuxGZTXIkmUFHzUjZ7purQ
         IzNnk1xhtthHQnfX57dsxs6RPM4F5V6HsSCyKAM9FN1hM+B/2hicxIgA1ft7TlAEVK7f
         TfT8zDmHLbFeOwTIp5fhyK+NTgPLdnBnKTmX5z7iNZ9UuuWibN61fbYnWschkc40KI8N
         elmg==
X-Gm-Message-State: AOAM532KQHZouEt8Q0IEfmbznFHGw384FQjlMSh6CYaqNxhcHWzRwgnY
        BVDXn5NK288BM8QpMZbRAH1M/9l2yVVrx2mH2as=
X-Google-Smtp-Source: ABdhPJz/e7JiAYsDZvEwBhOAMlerze8YDJ5vxQmPuCnh2W4iZoFuZs2ZggKFSF3ovqjYrHkL9Tk7fTJ9P+M3BCDQN+o=
X-Received: by 2002:a0d:f882:0:b0:2f4:d830:6fd with SMTP id
 i124-20020a0df882000000b002f4d83006fdmr37215432ywf.387.1654675913287; Wed, 08
 Jun 2022 01:11:53 -0700 (PDT)
MIME-Version: 1.0
Sender: watcha.tiem@gmail.com
Received: by 2002:a05:6900:1b4f:0:0:0:0 with HTTP; Wed, 8 Jun 2022 01:11:52
 -0700 (PDT)
From:   Ethan Stevenson <eslaw20211@gmail.com>
Date:   Wed, 8 Jun 2022 01:11:52 -0700
X-Google-Sender-Auth: Fu-4rpt0osrARgwh8tdtmXAS1TA
Message-ID: <CANcVp83R=L1XvhWfe84m++FkUaoFA2RCAitx3nuny2gG4bavsA@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Did you get the e-mail which i sent you last week? Please confirm and
give me feedback
