Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C3D3674EA
	for <lists+linux-scsi@lfdr.de>; Wed, 21 Apr 2021 23:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343509AbhDUV6q (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 21 Apr 2021 17:58:46 -0400
Received: from mail-1.ca.inter.net ([208.85.220.69]:59119 "EHLO
        mail-1.ca.inter.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235570AbhDUV6p (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 21 Apr 2021 17:58:45 -0400
Received: from localhost (offload-3.ca.inter.net [208.85.220.70])
        by mail-1.ca.inter.net (Postfix) with ESMTP id A0C0C2EA049;
        Wed, 21 Apr 2021 17:58:09 -0400 (EDT)
Received: from mail-1.ca.inter.net ([208.85.220.69])
        by localhost (offload-3.ca.inter.net [208.85.220.70]) (amavisd-new, port 10024)
        with ESMTP id twWcpDTnVmQt; Wed, 21 Apr 2021 17:38:23 -0400 (EDT)
Received: from [192.168.48.23] (host-45-58-219-4.dyn.295.ca [45.58.219.4])
        (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dgilbert@interlog.com)
        by mail-1.ca.inter.net (Postfix) with ESMTPSA id 3584F2EA428;
        Wed, 21 Apr 2021 17:58:09 -0400 (EDT)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH 14/42] scsi: add scsi_result_is_good()
To:     Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org
References: <20210421174749.11221-1-hare@suse.de>
 <20210421174749.11221-15-hare@suse.de>
 <b510135a-3dca-e6e4-bdbb-f1ff3817cc29@acm.org>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <51b16b13-d4e3-f0e4-718e-357d04ed958f@interlog.com>
Date:   Wed, 21 Apr 2021 17:58:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b510135a-3dca-e6e4-bdbb-f1ff3817cc29@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2021-04-21 5:10 p.m., Bart Van Assche wrote:
> On 4/21/21 10:47 AM, Hannes Reinecke wrote:
>> +static inline bool scsi_result_is_good(struct scsi_cmnd *cmd)
>> +{
>> +    return (cmd->result == 0);
>> +}
> 
> Do we really need an inline function to compare an integer with zero? How about 
> open-coding this comparison in the callers of this function?
> 

Please don't open code it. Please fix it!
Spot the difference:

static inline int scsi_status_is_good(int status)
{
         /*
          * FIXME: bit0 is listed as reserved in SCSI-2, but is
          * significant in SCSI-3.  For now, we follow the SCSI-2
          * behaviour and ignore reserved bits.
          */
         status &= 0xfe;
         return ((status == SAM_STAT_GOOD) ||
                 (status == SAM_STAT_CONDITION_MET) ||
/*   >>>                   ^^^^^^^^^^^^^^^^^^^^^^                <<<        */
                 /* Next two "intermediate" statuses are obsolete in SAM-4 */
                 (status == SAM_STAT_INTERMEDIATE) ||
                 (status == SAM_STAT_INTERMEDIATE_CONDITION_MET) ||
                 /* FIXME: this is obsolete in SAM-3 */
                 (status == SAM_STAT_COMMAND_TERMINATED));
}

In sg3_utils' library I ignore the last three SAM_STATs. Not sure if ignoring
bit 0 is still required.

Without considering SAM_STAT_CONDITION_MET a good status, someone will be
scratching their head wondering why so many PRE-FETCH commands fail.

That command can be used when a sequence of READs to consecutive LBAs is
followed by a different (i.e. non-consecutive) READ. That last READ could
be preceded by PRE-FETCH(new_LBA, IMMED). Assuming there is processing
of the data from the consecutive LBAs to be done, when the time comes
for READ(new_LBA) the probability of its data being in the disk's cache is
increased.

Doug Gilbert
