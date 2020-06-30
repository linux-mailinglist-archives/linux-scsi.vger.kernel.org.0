Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 907D620FA8A
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Jun 2020 19:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbgF3R1y (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 30 Jun 2020 13:27:54 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:41608 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725872AbgF3R1x (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 30 Jun 2020 13:27:53 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id E216E8EE16A;
        Tue, 30 Jun 2020 10:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1593538073;
        bh=9Xn6UBDIxLFSPMg8h37zOBFki+CeA2g+YUJAv6sqZ7M=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=BRSKzxnBmfxjg4UhkyGTjUzkwMqxHxPWHJGu+hmjVJPVvDG1zQi+cj+BM5owPqmyP
         qxXY8m+s3A4fkZk+x2YMa/dfIW5jwlwXrvVkfZShlQUQuaRs7MSPpgNTBYOTtx9suR
         iEEF5riwiDYA6TkhPvb+0aF1PdnYaQfEQJAUA/9I=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MbachUaXS8a6; Tue, 30 Jun 2020 10:27:52 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 6E77D8EE079;
        Tue, 30 Jun 2020 10:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1593538072;
        bh=9Xn6UBDIxLFSPMg8h37zOBFki+CeA2g+YUJAv6sqZ7M=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=VWuZK2mfBUs2DqHwcrlqPFe7pBIO3rvXh4c1QCDh4tzI4TFN40qfYYl40bm1Jbx/U
         IWTU9kQ/MMYR1CC2pidu/qiNDMXlYxfzU0fHFiFSJ58eL/J0IAjVq/2R1WMf7+VASy
         GVdaVQxWiCV/Ta6btEewZQ0SyLjHhhG2rHP5i7FU=
Message-ID: <1593538071.4124.7.camel@HansenPartnership.com>
Subject: Re: [RFC] scsi: target: tcmu: running 32bit userspace on 64bit
 kernel
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Bodo Stroesser <bstroesser@ts.fujitsu.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Christie <michael.christie@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Date:   Tue, 30 Jun 2020 10:27:51 -0700
In-Reply-To: <2cc4fd9e-e96d-725b-c047-4bd26af604a6@ts.fujitsu.com>
References: <364c13da-6d4f-c28b-36b3-082db8c3de58@ts.fujitsu.com>
         <1593535964.4124.2.camel@HansenPartnership.com>
         <2cc4fd9e-e96d-725b-c047-4bd26af604a6@ts.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, 2020-06-30 at 19:17 +0200, Bodo Stroesser wrote:
> On 2020-06-30 18:52, James Bottomley wrote:
> > On Tue, 2020-06-30 at 18:49 +0200, Bodo Stroesser wrote:
[...]
> > > So we can compile a 32-bit application that works on 64-bit
> > > kernel without need to manipulate the include file prepared by
> > > the kernel.
> > > 
> > > What do you think? Do you know a better solution?
> > 
> > Can you not use something similar to the compat_ioctl
> > mechanism?  the job of the compat layer is to re-layout the input
> > and output structures to impedance match between 32 and 64 bit.
> > 
> > James
> > 
> 
> struct tcmu_cmd_entry is prepared by kernel and exposed to userspace
> via an mmap()ed uio device. From tcmu module point of view it is
> vmalloc area.
> 
> So there is no 'glue' code that could do conversion.

OK, so can't you do it like a vdso then?  For them we detect on mmap
what the architectural model is and map different areas depending on
that, so effectively you have a 64 and a 32 bit layout area and which
one you map depends on the architecture type you see coming into the
setup call.  You expect only one to be mapped and you only do extra
conversions on the impedance mismatch case.

> I'm not sure whether there is a way for tcmu to find out, what kind
> of userspace application is running. If it would know, it probably
> could prepare the entries accordingly.

I forget if the vdso switch is exposed outside the architecture, but an
inspection of the code should tell you.

> But worst case it could happen that entries prepared for 32-bit,
> after application stop and start, then are read by a new application
> version that is 64-bit ...

The userspace application absolutely knows its binary model.  The
kernel sort of knows (its known in the ELF32 execution model and the
like).

> Maybe we could add an configFS attribute allowing userspace to
> configure tcmu accordingly. A change of this attribute could also
> flush existing tcmu_cmd_entries. But that would mean that userspace
> application has to take care.
> 
> Isn't the compiler definition easier to use?

Well, yes, but that's an ABI change which I thought you were trying to
avoid?

James

