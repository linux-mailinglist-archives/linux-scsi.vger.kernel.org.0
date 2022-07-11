Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309E956D3A3
	for <lists+linux-scsi@lfdr.de>; Mon, 11 Jul 2022 06:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiGKEL5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 11 Jul 2022 00:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiGKELx (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 11 Jul 2022 00:11:53 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFA8186C7;
        Sun, 10 Jul 2022 21:11:52 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so7140281pjl.5;
        Sun, 10 Jul 2022 21:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=W/JFVuKNzZiqMBQi1p4ww29Ay2ETSokEw0yXEePEWoU=;
        b=fhQcyRbnxRxpm3f2eOxuKekaZ8QWFe2XYz1LIpr7CREzFnDd1jx5FNbAoNP7TL/DQF
         pbWdJfxk3aj6+ShIZLdOteip84Y3Ed9Z1Tq0eqCDISdhEmkz709wUxcO76Oowp1pOjsD
         CpS5ZWjPRcIc3Mbj9r5nb9uZVz0s85yh1q91KYSnBnP8sHL3tkE6go91VSUCWCgW/jDC
         8iHTCeZV5/s/pHVeVvxlj8yFUqwY+Vge88ZtG3ZQBdRb+rGugcNauyw8Y9kZtG3UuBFY
         OUVs2lj8k1NQ00nmXjyCsC8ecnVYlh92fXlHel9Oor66B0INoM0A+KgHU7pu6u66a69N
         kkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=W/JFVuKNzZiqMBQi1p4ww29Ay2ETSokEw0yXEePEWoU=;
        b=PaYZslUo9p0+/vrO2/zrBRFBz28A6/9OEJmi/uXiT8cxCZpr2D208Ei3C7KTHtDZvz
         zfMWbga3AsnPrENGrv8gh7wHo4jKKNO0jZDeF5YU/oFhjVEpoaQTEx3G974Xrd7JJXvg
         A44VQOJ4YMv7g59PJea1VzzeVDSkj6CKI7ZMIJEsgWsQAD+qoTBGbRbhv9lsZEkWsZCn
         LVqdDpC/ZWqfV2yMjbhE+A9tnEMYJFcYZzl5vqNggSGRkb5ZyC87fCmJrxQROCDS3kjP
         siM/DfcOYiFdY6q7AltagjMHsJfqjHtABbhPpS+Rfyw8s5a+r17bjAncxoq+uDZDActQ
         GH/g==
X-Gm-Message-State: AJIora9aI4O9OET6EixGDHJMBeYlNMv2gEr40tLZ7802FUpkxnjPexrf
        rDUUzFsJi6Pgtij06cmpMjEVRzA/0Do=
X-Google-Smtp-Source: AGRyM1u6V6WarwnPD8oaAwlInpzem1ovfj6nUjRSJWq75wdF+cJhGPkxYHUWmL5EGJZTRoDS+0FhGA==
X-Received: by 2002:a17:902:ccc7:b0:16c:484f:4c69 with SMTP id z7-20020a170902ccc700b0016c484f4c69mr3887520ple.118.1657512712410;
        Sun, 10 Jul 2022 21:11:52 -0700 (PDT)
Received: from [10.1.1.24] (222-155-0-244-adsl.sparkbb.co.nz. [222.155.0.244])
        by smtp.gmail.com with ESMTPSA id c76-20020a624e4f000000b0052592a8ef62sm3616710pfb.110.2022.07.10.21.11.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Jul 2022 21:11:51 -0700 (PDT)
Subject: Re: [PATCH v1 2/4] m68k - set up platform device for mvme147_scsi
To:     Arnd Bergmann <arnd@kernel.org>
References: <20220709001019.11149-1-schmitzmic@gmail.com>
 <20220709001019.11149-3-schmitzmic@gmail.com>
 <CAK8P3a0fisnrP0tO94Fy6ugvrw-KkCmDOpqraK4LC=GfV24rAg@mail.gmail.com>
Cc:     Linux/m68k <linux-m68k@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <98997c5b-6efd-b2bb-ccad-e9d7428c62d2@gmail.com>
Date:   Mon, 11 Jul 2022 16:11:46 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0fisnrP0tO94Fy6ugvrw-KkCmDOpqraK4LC=GfV24rAg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Arnd,

thanks for your review!

Am 11.07.2022 um 03:56 schrieb Arnd Bergmann:
> On Sat, Jul 9, 2022 at 2:10 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
>> +
>> +static const struct resource mvme147_scsi_rsrc[] __initconst = {
>> +       DEFINE_RES_MEM(MVME147_SCSI_BASE, 0xff),
>> +       DEFINE_RES_IRQ(MVME147_IRQ_SCSI_PORT),
>> +};
>
> The size should almost certainly be 0x100, not 0xff here.

OK, will fix that. The resource size is taken from one of the Amiga 
drivers and might be excessive for mvme147, but 0xff is certainly odd.

Cheers,

	Michael


> Otherwise this looks good to me.
>
>        Arnd
>
