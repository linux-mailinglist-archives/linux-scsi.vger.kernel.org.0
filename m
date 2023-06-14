Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFE87192C8
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Jun 2023 07:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbjFAFzj (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Jun 2023 01:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbjFAFzS (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Jun 2023 01:55:18 -0400
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F4810CA
        for <linux-scsi@vger.kernel.org>; Wed, 31 May 2023 22:54:06 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-783ff10cdbaso107763241.2
        for <linux-scsi@vger.kernel.org>; Wed, 31 May 2023 22:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685598545; x=1688190545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=222BY0SYS4nugQ0P0MJrMmdC8tsRz0lLhBmT4GRgFQc=;
        b=QPvq+CY8o/bzzCij7ed+4Uoe+Xc4th2wm5aDL+EP4ZtT76F45TCk91slLGZrHRyZ6e
         VWNvPDktedrQjYfQmtLJ7TiYJKehSwG4EQdRqPpinnSlfQKbxgwleS0H+Y1wJV64s4rL
         NW1aH0j35BVvo7Ut34/L4Uh61qDYMyHZ1a+JgVqQlNq65mRT5laZ4P82FSGCkyRge2T4
         GCBUM3pg5ivAF2MYHFZT5C2qayYkrGj9OlNjEFTVc2msVrOWUYBIY90URGXWtB730Qcd
         5x+RepAvfIFSXRBJhG4I9AiywrlUst9JgPQVO6NXxtMcg0pAqEOsCY4X4YhiaUI7avhK
         nx3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685598545; x=1688190545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=222BY0SYS4nugQ0P0MJrMmdC8tsRz0lLhBmT4GRgFQc=;
        b=c7XAGi7aVKINIaHd8vwbt81YfDaIW6aUCzeeauvFtQtqZLQZUXP1iSoWTEuam6BEeU
         OXXNqmzL/r1LvXzV2q2dUOdHutSIFv3+L5yfiXlOkEO0sAiVF2aM6JW2Av3172ZouOna
         6CIYOPwNSZTxWTgmbsiFB3oeWtrqknNKCQUF80T+vccwT+bccQFseAjG8HfI27i9OR7j
         qBh54XmSvpxH3MfnTvw0Hrf8XW7hejoXDXKl/MrRLyBD1LqA3cxFn8K/If9Pvpuc3eSJ
         wmuAexwYX7fUudji8a6ToFaLPQyxonm7bc9zFY1z4GhlE0uR6rt3posnfso5ttrtoXHs
         N8hw==
X-Gm-Message-State: AC+VfDwwhw2FcPITnbcXIudpCayRllnY0Wh+oOhXwykc6OxPanSgTOBq
        d8RXmXeHCaoB2dPjDGHUTz2q8MXPFJuv8d6hLOvBIA==
X-Google-Smtp-Source: ACHHUZ7oulECEBrLYMu3LXhunZNTKM5SJWw4v30Vjm2MvCtsuv+q1Cu+msYCLP+eCPGuF/XKhJHgqUYgLMHFHQh2idA=
X-Received: by 2002:a67:eb4b:0:b0:434:2f6a:6009 with SMTP id
 x11-20020a67eb4b000000b004342f6a6009mr3583474vso.8.1685598545449; Wed, 31 May
 2023 22:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220405093759.1126835-1-alex.bennee@linaro.org>
 <20230531191007.13460-1-shyamsaini@linux.microsoft.com> <SN7PR11MB6850DA4A185E3429B62531CD84499@SN7PR11MB6850.namprd11.prod.outlook.com>
 <CAC_iWjKAdimEH0SsC_z9QuFS4sGLp2BVzx03s+RKvcLXY25kuQ@mail.gmail.com>
In-Reply-To: <CAC_iWjKAdimEH0SsC_z9QuFS4sGLp2BVzx03s+RKvcLXY25kuQ@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 1 Jun 2023 11:18:54 +0530
Message-ID: <CAFA6WYPKeJYTzvnZkoL_dw6uXSkhAh6uxoEOWHYU7oLNRDRWaA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] rpmb subsystem, uapi and virtio-rpmb driver
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc:     "Zhu, Bing" <bing.zhu@intel.com>,
        Shyam Saini <shyamsaini@linux.microsoft.com>,
        "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
        "code@tyhicks.com" <code@tyhicks.com>,
        "Matti.Moell@opensynergy.com" <Matti.Moell@opensynergy.com>,
        "arnd@linaro.org" <arnd@linaro.org>,
        "hmo@opensynergy.com" <hmo@opensynergy.com>,
        "joakim.bech@linaro.org" <joakim.bech@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "maxim.uvarov@linaro.org" <maxim.uvarov@linaro.org>,
        "ruchika.gupta@linaro.org" <ruchika.gupta@linaro.org>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "Huang, Yang" <yang.huang@intel.com>,
        "jens.wiklander@linaro.org" <jens.wiklander@linaro.org>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, 1 Jun 2023 at 11:02, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Bing
>
> On Thu, 1 Jun 2023 at 04:03, Zhu, Bing <bing.zhu@intel.com> wrote:
> >
> > As an alternative, Is it possible to change ftpm design not to depend o=
n RPMB access at the earlier/boot stage? Because to my understanding, typic=
ally PCRs don't require persistent/NV storage (for example, before RPMB or =
tee-supplicant is ready, use TEE memory instead as temporary storage)
>
> I am not entirely sure this will solve our problem here.  You are
> right that we shouldn't depend on the supplicant to extend PCRs. But
> what happens if an object is sealed against certain PCR values?  We
> are back to the same problem

+1

Temporary storage may be a stop gap solution for some use-cases but
having a fast path access to RPMB via kernel should be our final goal.
I would suggest we start small with the MMC subsystem to expose RPMB
access APIs for OP-TEE driver rather than a complete RPMB subsystem.

-Sumit

>
> Thanks
> /Ilias
> >
> > Bing
> >
> > IPAS Security Brown Belt (https://www.credly.com/badges/69ea809f-3a96-4=
bc7-bb2f-442c1b17af26)
> > System Software Engineering
> > Software and Advanced Technology Group
> > Zizhu Science Park, Shanghai, China
> >
> > -----Original Message-----
> > From: Shyam Saini <shyamsaini@linux.microsoft.com>
> > Sent: Thursday, June 1, 2023 3:10 AM
> > To: alex.bennee@linaro.org
> > Cc: code@tyhicks.com; Matti.Moell@opensynergy.com; arnd@linaro.org; Zhu=
, Bing <bing.zhu@intel.com>; hmo@opensynergy.com; ilias.apalodimas@linaro.o=
rg; joakim.bech@linaro.org; linux-kernel@vger.kernel.org; linux-mmc@vger.ke=
rnel.org; linux-scsi@vger.kernel.org; maxim.uvarov@linaro.org; ruchika.gupt=
a@linaro.org; Winkler, Tomas <tomas.winkler@intel.com>; ulf.hansson@linaro.=
org; Huang, Yang <yang.huang@intel.com>; sumit.garg@linaro.org; jens.wiklan=
der@linaro.org; op-tee@lists.trustedfirmware.org
> > Subject: [PATCH v2 0/4] rpmb subsystem, uapi and virtio-rpmb driver
> >
> > Hi Alex,
> >
> > [ Resending, Sorry for the noise ]
> >
> > Are you still working on it or planning to resubmit it ?
> >
> > [1] The current optee tee kernel driver implementation doesn't work whe=
n IMA is used with optee implemented ftpm.
> >
> > The ftpm has dependency on tee-supplicant which comes once the user spa=
ce is up and running and IMA attestation happens at boot time and it requir=
es to extend ftpm PCRs.
> >
> > But IMA can't use PCRs if ftpm use secure emmc RPMB partition. As optee=
 can only access RPMB via tee-supplicant(user space). So, there should be a=
 fast path to allow optee os to access the RPMB parititon without waiting f=
or user-space tee supplicant.
> >
> > To achieve this fast path linux optee driver and mmc driver needs some =
work and finally it will need RPMB driver which you posted.
> >
> > Please let me know what's your plan on this.
> >
> > [1] https://optee.readthedocs.io/en/latest/architecture/secure_storage.=
html
> >
> > Best Regards,
> > Shyam
