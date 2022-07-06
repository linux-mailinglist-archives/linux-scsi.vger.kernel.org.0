Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C470568F0D
	for <lists+linux-scsi@lfdr.de>; Wed,  6 Jul 2022 18:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbiGFQZp (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 6 Jul 2022 12:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233801AbiGFQZm (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 6 Jul 2022 12:25:42 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8768025C7B
        for <linux-scsi@vger.kernel.org>; Wed,  6 Jul 2022 09:25:40 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id s13-20020a0568301e0d00b00616ad12fee7so12151739otr.10
        for <linux-scsi@vger.kernel.org>; Wed, 06 Jul 2022 09:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Uk0kx353H+gGEfDDNFmV1k9XciWZTV5g6S3ovbgNaYc=;
        b=gQqyK8e6UjlfcdDaTwuapyo5u6WCZfyOyUo3o+rhjn0y6o6twgaREpXrfDzmOzwGI4
         Xf5d+/XrpNxcXy2P+S6Arj4mikQrOs7tn8Zi0G2PfPlx9DQA87CxYpyOLLtznadJxTdi
         YU7sooZaHsJFupUvH9P8JYZr92v53Ewf8CO0k3ftFj8+aClkoUt3Yeir2cznint1XJiZ
         4cnnfCCVb7Hw+AuxNnLfsLhkSiPepj+3DXTkepicubsvvsJ96h6vgKMiBtxHx7xscJfy
         hYzHaxW5ZBme1j+WHTF16ek8bjQKD3UIMwwyTBOCWbSiEqVVtQB8nsIb5WVv5H9A4LNz
         CKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=Uk0kx353H+gGEfDDNFmV1k9XciWZTV5g6S3ovbgNaYc=;
        b=JjC7oUVjCMYTJkSTQEDSHMpJiQOKb8xb8eT+0rqyESk+UEdjEIaBrn8KjvYJE/Em25
         BVeOpbLwnIe9JFOyupxwMCsaALYCiA0jYTf1aVVJeeoz5sSTcCECW5D+0Ldw84NTMyvy
         GW/EzsbEX6Xtm0R2gwFEQAm6FLkRtS4oY5lCWtri9RAHq3DQaJllYDmGWFV+TzmK1xb+
         f1JAI46kI0KEICiLDxXn3hPbIImybDLVNvb1rcnoGgAdFnhnaAbJ9ZWFOYTDc6+l5zQd
         XZeyHtM2KO4rB5+14HDRi/t2CVGt/jgzV1H7gpO5g+5+XYdrXo6gSh4xTvX5id+aGC1Y
         In/Q==
X-Gm-Message-State: AJIora9DB+vA5YJBzB4QLTak7KVzy4kYUHhqx7p119i7bl/kSpMg5hT9
        cFhSaFcSu33dS2kEi5UGr9Kfj5k7fFVn609sbd0=
X-Google-Smtp-Source: AGRyM1uBbeke8wh9mfu4ZJ+5+4KGZ7yZiqEh677cojeZ6bpzgdiE8hjHgHdURg0ZRw4xgz6IWLD+HWiH2GsizApoY9E=
X-Received: by 2002:a05:6830:1d5b:b0:616:de98:2556 with SMTP id
 p27-20020a0568301d5b00b00616de982556mr18845241oth.367.1657124739940; Wed, 06
 Jul 2022 09:25:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:4545:0:0:0:0:0 with HTTP; Wed, 6 Jul 2022 09:25:39 -0700 (PDT)
Reply-To: sgtkaylla202@gmail.com
From:   Kayla Manthey <avrielharry73@gmail.com>
Date:   Wed, 6 Jul 2022 16:25:39 +0000
Message-ID: <CAFSKFDY94cW50tP6DDz2oHbhf0ni4DDv1hxhbaqXPu50CZ_Xug@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=4.2 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

LS0gDQrQl9C00YDQsNCy0L4g0LTRgNCw0LPQsA0K0JLQtSDQvNC+0LvQsNC8LCDQtNCw0LvQuCDR
mNCwINC00L7QsdC40LLRgtC1INC80L7RmNCw0YLQsCDQv9GA0LXRgtGF0L7QtNC90LAg0L/QvtGA
0LDQutCwLCDQstC4INCx0LvQsNCz0L7QtNCw0YDQsNC8Lg0K
