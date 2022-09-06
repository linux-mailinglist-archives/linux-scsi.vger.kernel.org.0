Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E2D5AF19B
	for <lists+linux-scsi@lfdr.de>; Tue,  6 Sep 2022 19:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235598AbiIFRD6 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 6 Sep 2022 13:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbiIFRDL (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 6 Sep 2022 13:03:11 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4515618E3A
        for <linux-scsi@vger.kernel.org>; Tue,  6 Sep 2022 09:49:53 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-127d10b4f19so3845004fac.9
        for <linux-scsi@vger.kernel.org>; Tue, 06 Sep 2022 09:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=osSAgKM1j6DRNQcQXA842NXUQk2GubTJs0svjrfNTko=;
        b=Ha+rsZzmwY/PZt9KWr1mDdKYIfWwmaFUS2sNl3pUBfXa5ULfWo1sRGpJ0UbpVrjcqE
         KcbZrwKbbfLrvbK4vSfBb8pp4mmWS7MdgCl+30wRRXOJro8jvCxBwushJLRhanMlbziF
         7OUanGVUMUrxQcjGNQ/RRyVkEyAIIbrJetDXopMWWHTgKYT3y+4GIVhhxshjzdCWVd6t
         TjdPJobAccaG4OsYnB86feXpytanxLkxaibo2vn6llsUiFcRH/xH/DVbRMBkGz8/yFai
         yG3J5xxIh65BcKimdBUSvh0nfEt+1NWgiT2bRz2EBcNEKKr6AlaYg8BUNvlKoBOwgMsT
         Ek3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=osSAgKM1j6DRNQcQXA842NXUQk2GubTJs0svjrfNTko=;
        b=aBe4e8A4btj5WPw8U1HtHD96YMCrwKVnA0Aq4BB0Fwf6gAJV/Xi41UQ/+PK16w6/Q/
         D5IJA3D7ylUoBXyGA55r1GPiF8G6km6nAe6iYUvqRj3Jb+jHMz5XWms2GaMm+ViV1UzV
         vFjt8ot38UM82KjCXDwNL7NYM9ipktKCpXJIZNCQXXWVJVPsQ+DzoqoQgI1S/fjeShyb
         84Lj227I8pJxAbXfjYpeQMyxvLWfhSiwvCQNcCGGJXJLoqqEhHaXvpJIIDQ8tMOxEUtZ
         IyTRugiMI3Yg/MjbwN64Ub1/vEHBAsG6nPgBM4fwFTlMGa7qtkxJYaVU+y8Y4ExU8rlg
         hwyw==
X-Gm-Message-State: ACgBeo0oiJYdK7rlAAfmF5gNwM4UcAm+qX16DpGYcJP9y8J9TokJlGnZ
        qkxyBXCc9K1SOw/OJRFci1o6601jpKrbi1AA/Bs=
X-Google-Smtp-Source: AA6agR5hCUnHLQ4dFfc/sCqrW8MqXRcrJZAAC05xLl1hMmY70P2/ZDIaebHt3HF3wAbSl4ZZlIDEKfnEYfEeEKPdOYE=
X-Received: by 2002:a05:6870:96a9:b0:126:dbc4:76db with SMTP id
 o41-20020a05687096a900b00126dbc476dbmr7265577oaq.174.1662482992447; Tue, 06
 Sep 2022 09:49:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:6c86:0:0:0:0:0 with HTTP; Tue, 6 Sep 2022 09:49:52 -0700 (PDT)
From:   Michelle Goodman <michellegoodman45@gmail.com>
Date:   Tue, 6 Sep 2022 16:49:52 +0000
Message-ID: <CA+PxuvXQ6S54x3u-bTgdVMOOC2m_PRnVicPwes1FFAMeO17zKg@mail.gmail.com>
Subject: Vielen Dank.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hallo, ich hoffe du hast meine Nachricht erhalten.
Ich brauche schnelle Antworten

Vielen Dank.
Michelle
