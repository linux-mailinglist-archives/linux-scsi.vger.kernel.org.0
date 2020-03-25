Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 328F21933D2
	for <lists+linux-scsi@lfdr.de>; Wed, 25 Mar 2020 23:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgCYWlg (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 25 Mar 2020 18:41:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:47392 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727358AbgCYWlg (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 25 Mar 2020 18:41:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3AAD1AD66;
        Wed, 25 Mar 2020 22:41:34 +0000 (UTC)
Message-ID: <86e85687933f6875ab75f927981fc43a9a257b74.camel@suse.com>
Subject: Re: [PATCH v2 1/3] scsi: qla2xxx: avoid sending mailbox commands if
 firmware is stopped
From:   Martin Wilck <mwilck@suse.com>
To:     Arun Easi <aeasi@marvell.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Quinn Tran <qutran@marvell.com>,
        Roman Bolshakov <r.bolshakov@yadro.com>,
        Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>,
        Daniel Wagner <dwagner@suse.de>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org
Date:   Wed, 25 Mar 2020 23:41:36 +0100
In-Reply-To: <alpine.LRH.2.21.9999.2003251506260.12727@irv1user01.caveonetworks.com>
References: <20200205214422.3657-1-mwilck@suse.com>
         <20200205214422.3657-2-mwilck@suse.com>
         <alpine.LRH.2.21.9999.2003241648560.12727@irv1user01.caveonetworks.com>
         <dfbd88461ef4b5f56a83db7095c6e3f36b5a485e.camel@suse.com>
         <4fb2d29be88dbef2050cf51210d8e4e14a4b8ac2.camel@suse.com>
         <940e20ba5d117b6fd181e0acdac14b7682ff2d64.camel@suse.com>
         <alpine.LRH.2.21.9999.2003251506260.12727@irv1user01.caveonetworks.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, 2020-03-25 at 15:13 -0700, Arun Easi wrote:
> On Wed, 25 Mar 2020, 11:21am, Martin Wilck wrote:
> 
> > On Wed, 2020-03-25 at 18:20 +0100, Martin Wilck wrote:
> > > Perhaps the (!fw_started) condition should be treated like
> > > ABORT_ISP_ACTIVE in qla2x00_mailbox_command, i.e. execute only if
> > > is_rom_cmd() returns true?
> > 
> > No, this won't be sufficient, as e.g. MBC_IOCB_COMMAND_A64 is in
> > rom_cmds[], but has been found to hang (this is why I had the hunk
> > in
> > qla24xx_fabric_logout()). The list of mailbox commands
> > that must be passed on when the FW is stopped has to be shorter
> > than
> > rom_cmds[].
> > 
> 
> With your patch 2/3, where UNLOADING is set prior to the reset of
> chip, in 
> place this issue should be largely addressed. Basically, paths that
> send 
> out request to wire check UNLOADING bit (if any path is missing
> that, 
> should add the check) before sending it out.
> 
> Now with UNLOADING set (with your patch 2/3), chip reset, and all 
> outstanding command's completion called (qla2x00_abort_isp_cleanup) I
> see 
> less chance of anything being sent out. If you see any issue with
> your 
> patches 1 & 2 (addressing my comments) applied, let me know and we
> can 
> tackle then. How about that?

It sounds like a plan. Although it means that I just wasted time trying
to figure out which mailbox commands need to be processed even if the
firmware is down :-)

Thanks,
Martin


