Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0305174D317
	for <lists+linux-scsi@lfdr.de>; Mon, 10 Jul 2023 12:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbjGJKPM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 10 Jul 2023 06:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbjGJKOy (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 10 Jul 2023 06:14:54 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B367418B
        for <linux-scsi@vger.kernel.org>; Mon, 10 Jul 2023 03:13:23 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-c5ce57836b8so5067689276.1
        for <linux-scsi@vger.kernel.org>; Mon, 10 Jul 2023 03:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688984002; x=1691576002;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NdiupA6cBTfp2T4wmKkTrqOertN7BIFSXZbmCnqIkpY=;
        b=s2DN1m9HoZjLxZKTs2uOGdGCgGfrT1f47pOmr4AfN7p4FSN1hKb10IMsc+r1FS5P3k
         Em3q8HEWQjQ7PMTDpfyj3h0n66aB7BC369s1v3wgRTz9A39IJGWauc2R8ygxNcwVl+lm
         h0+cfYny/gTkUEtJVPXzDKr3hA+nJ7t7jjLckOQxhiw93pQjAiMzaXt31/mWlgX6Nhpo
         E2qje0F0+Zy+2rf/SRhQv1w8uidSRaOcKI+lrhrxuBHLNRxX3F0hIFC1czr+Od4tQZ1J
         kGqw3ZgUXR6slxQFgw6NU6zUralh2HytcFJF22KG9t3JkQNSxjlVt6z6yumJf024du2V
         QoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688984002; x=1691576002;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NdiupA6cBTfp2T4wmKkTrqOertN7BIFSXZbmCnqIkpY=;
        b=igAdB86uJ3GHccVXatoH3Niu5A7jS1HAW2/gGmpeR/0eT8fjypU9TBTxVXNdnlzi25
         yl9IrxFibe03ZyhWhr9R6uA4+lp2O/Gh0uxgtEKi87bexm55uEHQhiaH0fW60b/4wWC0
         OVGQVq1UvLlB2LWrAamgXLhZ7BfE3Q6C3noveDtNZ1/otlORro9ZdmhxEyp4IcYRJJWR
         pNUhqU2UoCllZtpFsDOo3fk3sTwIBEJNnuU09WcTB9XzUotYd0LQI7JdzR4i8kywQl2u
         Tfan1l9n/BQ/iI1buqSPfa/HjTCdBdSVN47YWmBjF+qTKq+6zNMAlQqIY0fC7rYQnDBf
         xg/A==
X-Gm-Message-State: ABy/qLZddK3uLn6LppC+pOgFPxUljtxbQVuu7AWEG2AA8+IqEKPayXSh
        42rrXbBE41rhY1kh8kq9DPpHbItLxUkQ5DqDA2s=
X-Google-Smtp-Source: APBJJlEFPZi5HLMVBalZV+LcV8QjkMBSa8ARwBQTNAJvi+tpS3w8x1j5Gzm72sc6qNgZ0kJKhMErdQzYaWTWUhrn1HI=
X-Received: by 2002:a25:d656:0:b0:c86:55c7:d04d with SMTP id
 n83-20020a25d656000000b00c8655c7d04dmr2133934ybg.27.1688984001908; Mon, 10
 Jul 2023 03:13:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:bc07:b0:4e3:c44d:401e with HTTP; Mon, 10 Jul 2023
 03:13:21 -0700 (PDT)
Reply-To: mariaelisabethschaeffler.de@gmail.com
From:   Frau Maria Elisabeth Schaeffler <achiyaman7@gmail.com>
Date:   Mon, 10 Jul 2023 11:13:21 +0100
Message-ID: <CAHzeGYuDxNeTxcpxrt5=JDvRRE4UHQKf6sZKYp6zVDgEycoiCg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

--=20
Sie haben eine Spende f=C3=BCr humanit=C3=A4re Arbeit erhalten. E-Mail f=C3=
=BCr
 Informationen: mariaelisabethschaeffler.de@gmail.com
