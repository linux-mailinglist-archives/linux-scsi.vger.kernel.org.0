Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B705936BE88
	for <lists+linux-scsi@lfdr.de>; Tue, 27 Apr 2021 06:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhD0Ekn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 27 Apr 2021 00:40:43 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:43452 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhD0Ekm (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 27 Apr 2021 00:40:42 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 2E12E22608;
        Tue, 27 Apr 2021 00:39:55 -0400 (EDT)
Date:   Tue, 27 Apr 2021 14:39:54 +1000 (AEST)
From:   Finn Thain <fthain@fastmail.com.au>
To:     Hannes Reinecke <hare@suse.de>
cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Bart van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 24/39] wd33c93: translate message byte to host byte
In-Reply-To: <46bf6a5b-966c-f379-059f-3fafce82692a@suse.de>
Message-ID: <3d527f20-fc8a-9ade-7c6-58d7d2e86d22@nippy.intranet>
References: <20210423113944.42672-1-hare@suse.de> <20210423113944.42672-25-hare@suse.de> <496782e-7377-ac6b-874-213f4e520b6@nippy.intranet> <46bf6a5b-966c-f379-059f-3fafce82692a@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, 26 Apr 2021, Hannes Reinecke wrote:

> On 4/24/21 11:20 AM, Finn Thain wrote:
> > On Fri, 23 Apr 2021, Hannes Reinecke wrote:
> > 
> >> Instead of setting the message byte translate it to the appropriate
> >> host byte. As error recovery would return DID_ERROR for any non-zero
> >> message byte the translation doesn't change the error handling.
> >>
> >> Signed-off-by: Hannes Reinecke <hare@suse.de>
> >> ---
> >>  drivers/scsi/wd33c93.c | 46 ++++++++++++++++++++++++------------------
> >>  1 file changed, 26 insertions(+), 20 deletions(-)
> >>
> >> diff --git a/drivers/scsi/wd33c93.c b/drivers/scsi/wd33c93.c
> >> index a23277bb870e..187b363db00e 100644
> >> --- a/drivers/scsi/wd33c93.c
> >> +++ b/drivers/scsi/wd33c93.c
> >> @@ -1176,13 +1176,14 @@ wd33c93_intr(struct Scsi_Host *instance)
> >>  			if (cmd->SCp.Status == ILLEGAL_STATUS_BYTE)
> >>  				cmd->SCp.Status = lun;
> >>  			if (cmd->cmnd[0] == REQUEST_SENSE
> >> -			    && cmd->SCp.Status != SAM_STAT_GOOD)
> >> -				cmd->result =
> >> -				    (cmd->
> >> -				     result & 0x00ffff) | (DID_ERROR << 16);
> >> -			else
> >> -				cmd->result =
> >> -				    cmd->SCp.Status | (cmd->SCp.Message << 8);
> >> +			    && cmd->SCp.Status != SAM_STAT_GOOD) {
> >> +				set_host_byte(cmd, DID_ERROR);
> >> +				set_status_byte(cmd, SAM_STAT_GOOD);
> >> +			} else {
> >> +				set_host_byte(cmd, DID_OK);
> >> +				translate_msg_byte(cmd, cmd->SCp.Message);
> >> +				set_status_byte(cmd, cmd->SCp.Status);
> >> +			}
> >>  			cmd->scsi_done(cmd);
> >>  
> >>  /* We are no longer  connected to a target - check to see if
> >> @@ -1262,11 +1263,15 @@ wd33c93_intr(struct Scsi_Host *instance)
> >>  		    hostdata->connected = NULL;
> >>  		hostdata->busy[cmd->device->id] &= ~(1 << (cmd->device->lun & 0xff));
> >>  		hostdata->state = S_UNCONNECTED;
> >> -		if (cmd->cmnd[0] == REQUEST_SENSE && cmd->SCp.Status != SAM_STAT_GOOD)
> >> -			cmd->result =
> >> -			    (cmd->result & 0x00ffff) | (DID_ERROR << 16);
> >> -		else
> >> -			cmd->result = cmd->SCp.Status | (cmd->SCp.Message << 8);
> >> +		if (cmd->cmnd[0] == REQUEST_SENSE &&
> >> +		    cmd->SCp.Status != SAM_STAT_GOOD) {
> >> +			set_host_byte(cmd, DID_ERROR);
> >> +			set_status_byte(cmd, SAM_STAT_GOOD);
> >> +		} else {
> >> +			set_host_byte(cmd, DID_OK);
> >> +			translate_msg_byte(cmd, cmd->SCp.Message);
> >> +			set_status_byte(cmd, cmd->SCp.Status);
> >> +		}
> >>  		cmd->scsi_done(cmd);
> >>  
> >>  /* We are no longer connected to a target - check to see if
> >> @@ -1295,14 +1300,15 @@ wd33c93_intr(struct Scsi_Host *instance)
> >>  			hostdata->busy[cmd->device->id] &= ~(1 << (cmd->device->lun & 0xff));
> >>  			hostdata->state = S_UNCONNECTED;
> >>  			DB(DB_INTR, printk(":%d", cmd->SCp.Status))
> >> -			    if (cmd->cmnd[0] == REQUEST_SENSE
> >> -				&& cmd->SCp.Status != SAM_STAT_GOOD)
> >> -				cmd->result =
> >> -				    (cmd->
> >> -				     result & 0x00ffff) | (DID_ERROR << 16);
> >> -			else
> >> -				cmd->result =
> >> -				    cmd->SCp.Status | (cmd->SCp.Message << 8);
> >> +			if (cmd->cmnd[0] == REQUEST_SENSE
> >> +			    && cmd->SCp.Status != SAM_STAT_GOOD) {
> >> +				set_host_byte(cmd, DID_ERROR);
> >> +				set_status_byte(cmd, SAM_STAT_GOOD);
> >> +			} else {
> >> +				set_host_byte(cmd, DID_OK);
> >> +				translate_msg_byte(cmd, cmd->SCp.Message);
> >> +				set_status_byte(cmd, cmd->SCp.Status);
> >> +			}
> >>  			cmd->scsi_done(cmd);
> >>  			break;
> >>  		case S_PRE_TMP_DISC:
> >>
> > 
> > I think these three hunks all have the same mistake, which would force 
> > SAM_STAT_GOOD.
> > 
> Which mistake was that again?
> 

I noticed that the old code,
	cmd->result = (cmd->result & 0x00ffff) | (DID_ERROR << 16);
preserves the status byte whereas the new code clobbers it. This was not 
mentioned in the commit log.

Now that I've looked a bit deeper and failed to find any 
scsi_eh_prep_cmnd()/scsi_eh_restore_cmnd() that would complicate the 
cmd->cmnd[0] == REQUEST_SENSE comparison, I now think clobbering the 
status byte is harmless (though redundant).

So please disregard my objection. Sorry for the noise.
