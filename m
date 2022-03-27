Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF044E86DF
	for <lists+linux-scsi@lfdr.de>; Sun, 27 Mar 2022 10:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiC0IQd (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 27 Mar 2022 04:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiC0IQb (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 27 Mar 2022 04:16:31 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79862286EE
        for <linux-scsi@vger.kernel.org>; Sun, 27 Mar 2022 01:14:53 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 17so15417456lji.1
        for <linux-scsi@vger.kernel.org>; Sun, 27 Mar 2022 01:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=nZ275Tm5MzLa8QyOb/BmmEnnwnBICW4Wrh2vH+M44mw=;
        b=AdMshB3Fe/c1dqzJvH6cnnA5Iv+EDyZZejpjXel7NVdRbEjuwicQoVfl+jHr7rnHOV
         lM822nFmGcvMTyLD/t0h0X35gR/b0SxwD9P+Cty56XrjKHYkU62IcHEY99qYD8Wssv3Y
         TprHcQaxqGGW3m86vsAoZd+ebDKs0Vr85s5D3VOffDzk6Ii/Qa494l0mfpQcqDYB2ZmE
         n3HF0x+0vT/pPtYjgL+9YZc+sE4O0abaeasHKlaSZzTSvBvm4/oCj8LF2yGpNDlUwNRT
         COhMjHoOhakdTbuR94Cx+gOPEcxdIknxw/jADTehL8hSxDAZT92j9v0RH96dWbYWGN7c
         Bw6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=nZ275Tm5MzLa8QyOb/BmmEnnwnBICW4Wrh2vH+M44mw=;
        b=GbDB50DEprvfyOKEG4vll7BhrpHFl0zjCKtahsquDWRhN5VMQuqaAu+P8bQaYEEukI
         iQhjOhqwM3hfThsb3xvO2/POMsmYoBE4CRwVnov+rac58leYnd7VwKhYrHsrcjp8dkcD
         KUrnwmQMHJuNky+ugA8lb3oKa+tSq59zDendff1gbXMoTAKELXEDMjRiQB5IHe0jk2bC
         saHWjw/gPIeJcgb2JOg123IvKFNcos3hY1U7GaHSCqsRhaUHsJMXoBSEG8NZN9eWskW0
         x00reRciJZFVLVDr58JDG8xwl1MBSC6vgcECgiGHO14fNbS1VHD5kuPthsrG1SrHZ1XH
         EWJA==
X-Gm-Message-State: AOAM533n1xTAbZlEwfHvPqNgWLUEah2/zblD7mPvlqTLdZctTQhxRL1L
        X+dPkf+E4GFhY820n0Wnk+HA8KsQWoLLIixC7mg=
X-Google-Smtp-Source: ABdhPJwTLm1c/g5RSvYRl9ifLC3SNKIu7dDDs6q2gHmVKQDNhUVyIo/ewTzdCRLDi/WXXc1eRnTD0yKpY2mkLlOdX6w=
X-Received: by 2002:a05:651c:1501:b0:249:8d28:5659 with SMTP id
 e1-20020a05651c150100b002498d285659mr15520959ljf.138.1648368891612; Sun, 27
 Mar 2022 01:14:51 -0700 (PDT)
MIME-Version: 1.0
From:   Badalian Vyacheslav <slavon.net@gmail.com>
Date:   Sun, 27 Mar 2022 11:14:40 +0300
Message-ID: <CALmWCAC=tewgc-611_ZD6hAPp1Pe9wc2K0qk9Xd9jkrR8+JZ0Q@mail.gmail.com>
Subject: [PATCH] mpt3sas: Fix system falling into readonly mode
To:     Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Sorry for going back to an already accepted patch. Is it really the
maximum and not the minimum? After all, at the maximum there will
always be 32 even if there are fewer channels?

max_t(u8,MPT_MAX_HBA_NUM_PHYS, num_phys);

The idea, as I understand it, should be in "no more than MPT_MAX_HBA_NUM_PHYS"?

If everything is correct, then please ignore this letter.
