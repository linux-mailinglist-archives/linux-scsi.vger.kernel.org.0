Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B07CB12044F
	for <lists+linux-scsi@lfdr.de>; Mon, 16 Dec 2019 12:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfLPLpl (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 16 Dec 2019 06:45:41 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:36832 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727286AbfLPLpk (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 16 Dec 2019 06:45:40 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 2B95A411F8;
        Mon, 16 Dec 2019 11:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        in-reply-to:content-disposition:content-type:content-type
        :mime-version:references:message-id:subject:subject:from:from
        :date:date:received:received:received; s=mta-01; t=1576496736;
         x=1578311137; bh=uPD/fbHoiIx1bTPx6jKKHiwZUnE1+lK4eMqoYLbWwhg=; b=
        Xbrug2hTKp69j39aGJx4RXAxb7CI04UCBEApbqhS1K84EP4PInXHmFs0DYJqKq9R
        1t581oOhaMzapMlzFI9j+z/CjyjzL1airOMJdybgCNt6y1fq7fOH2QFanDFouPqd
        iK0C2SfuhjoMxS8V/gETSC8WpI56rhSa/Y2EW/cgXeE=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bbLv69KnqkCf; Mon, 16 Dec 2019 14:45:36 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 0C02A43C73;
        Mon, 16 Dec 2019 14:45:36 +0300 (MSK)
Received: from localhost (172.17.128.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 16
 Dec 2019 14:45:35 +0300
Date:   Mon, 16 Dec 2019 14:45:35 +0300
From:   Roman Bolshakov <r.bolshakov@yadro.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Martin Wilck <mwilck@suse.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        <linux-scsi@vger.kernel.org>, Quinn Tran <qutran@marvell.com>,
        Martin Wilck <mwilck@suse.com>,
        Daniel Wagner <dwagner@suse.de>, <linux@yadro.com>
Subject: Re: [PATCH 3/4] qla2xxx: Fix point-to-point mode for qla25xx and
 older
Message-ID: <20191216114535.7ijs2nwqwrljq6pa@SPB-NB-133.local>
References: <20191209180223.194959-1-bvanassche@acm.org>
 <20191209180223.194959-4-bvanassche@acm.org>
 <fdff60ffaacad1b3a850942f61bdd92ab5bc6d12.camel@suse.de>
 <20191212200720.wbq2en3pnnpegrij@SPB-NB-133.local>
 <20191214010400.r6ord53kwbh2lmlm@SPB-NB-133.local>
 <86234568-0ab4-4efa-5f4f-05b0d604be3a@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <86234568-0ab4-4efa-5f4f-05b0d604be3a@acm.org>
X-Originating-IP: [172.17.128.60]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sat, Dec 14, 2019 at 04:09:41PM -0800, Bart Van Assche wrote:
> On 2019-12-13 17:04, Roman Bolshakov wrote:
> > Bart, what kernel do you use on initiator? Should we bring in
> > workarounds for initiators into mainline?
> 
> The setup I use to test point-to-point mode is as follows:
> * A single server equipped with a QLE2562 adapter.
> * The two ports of the QLE2562 adapter directly connected to each other.
> * Both FC ports are assigned to a VM such that if a kernel crash occurs
>   only the VM has to be rebooted (PCIe-passthrough).
> * The following in /etc/modprobe.d/qla2xxx.conf of the VM used for
>   testing:
> 
> options qla2xxx qlini_mode=dual ql2xextended_error_logging=0x5200b000
> 
> With this setup it is guaranteed that initiator and target are running
> the same kernel version.
> 
> I run all my tests with mainline kernels. Typically I run my tests on
> top of a merge of Martin's scsi-fixes and scsi-queue branches. Since the
> regression that I reported is a regression in the upstream kernel I
> think the fix should go into the upstream kernel.
> 

Hi Bart,

The setup details are helpful. Yes, I can reproduce it with
qlini_mode=dual. But it works with qlini_mode=disabled.

But, qlini_mode=dual works if target is created before initiator is
started.  So, the transition from initiator mode to target is the one
that needs a fix.

There first PLOGI after target creation fails because it complains about
wrong D_ID in Login/Logout IOCB:

qla2xxx [0000:00:07.0]-3873:1: Enter: PLOGI portid=0000ef
qla2xxx [0000:00:07.0]-3873:1: PLOGI 00000000003b33d0 00000000f1800318
qla2xxx [0000:00:07.0]-3873:1: PLOGI buffer:
qla2xxx [0000:00:07.0]-0909:1: +116   0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F
qla2xxx [0000:00:07.0]-0909:1: ----- -----------------------------------------------
qla2xxx [0000:00:07.0]-0909:1: 0000: 03 00 00 00 20 20 00 0c 88 00 08 00 00 ff 00 1f
qla2xxx [0000:00:07.0]-0909:1: 0010: 00 00 07 d0 21 00 00 24 ff 7f 35 c7 20 00 00 24
qla2xxx [0000:00:07.0]-0909:1: 0020: ff 7f 35 c7 00 00 00 00 00 00 00 00 00 00 00 00
qla2xxx [0000:00:07.0]-0909:1: 0030: 00 00 00 00 00 00 00 00 20 00 08 00 00 ff 00 04
qla2xxx [0000:00:07.0]-0909:1: 0040: 00 01 00 00 80 00 00 00 00 00 08 00 00 ff 00 00
qla2xxx [0000:00:07.0]-0909:1: 0050: 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00
qla2xxx [0000:00:07.0]-0909:1: 0060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
qla2xxx [0000:00:07.0]-0909:1: 0070: 00 00 00 00
qla2xxx [0000:00:07.0]-3873:1: PLOGI ELS IOCB:
qla2xxx [0000:00:07.0]-0909:1: +64    0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F
qla2xxx [0000:00:07.0]-0909:1: ----- -----------------------------------------------
qla2xxx [0000:00:07.0]-0909:1: 0000: 53 01 00 00 05 00 00 00 00 00 00 00 01 00 00 10
qla2xxx [0000:00:07.0]-0909:1: 0010: 00 00 00 00 01 00 03 00 ef 00 00 00 ef 00 00 00
qla2xxx [0000:00:07.0]-0909:1: 0020: 74 00 00 00 74 00 00 00 00 00 a5 30 00 00 00 00
qla2xxx [0000:00:07.0]-0909:1: 0030: 74 00 00 00 00 00 a6 30 00 00 00 00 74 00 00 00
qla2xxx [0000:00:07.0]-3874:1: ELS_DCMD PLOGI sent, hdl=5, loopid=0, to port_id 0000ef from port_id 0000ef
qla2xxx [0000:00:07.0]-583f:1: ELS IOCB Done -Driver ELS logo error hdl=5 comp_status=0x31 error subcode 1=0x19 error subcode 2=0x18 total_byte=0x74
qla2xxx [0000:00:07.0]-3872:1: ELS_DCMD ELS done rc 458752 hdl=5, portid=0000ef 21:00:00:24:ff:12:b1:a0
qla2xxx [0000:00:07.0]-28eb:1: qla2x00_els_dcmd2_sp_done 21:00:00:24:ff:12:b1:a0 cmd error fw_status 0x31 0x19 0x18

Also note, that the IOCB is sent from port 0000ef to port 0000ef. This
is definitely wrong and should be fixed. I'm still looking how it
reached the invalid state.

If qla2xxx target is started with qlini_mode=disabled in P2P mode,
initiator/target have port ids 000001/000002. The port with bigger WWPN
in the pair typically assigns 000001 to itself and 000002 to the peer.

Roman
