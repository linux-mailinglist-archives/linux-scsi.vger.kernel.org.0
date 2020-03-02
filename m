Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97242175B62
	for <lists+linux-scsi@lfdr.de>; Mon,  2 Mar 2020 14:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbgCBNPo (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 2 Mar 2020 08:15:44 -0500
Received: from verein.lst.de ([213.95.11.211]:43786 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726654AbgCBNPo (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 2 Mar 2020 08:15:44 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 54D7C68B20; Mon,  2 Mar 2020 14:15:41 +0100 (CET)
Date:   Mon, 2 Mar 2020 14:15:41 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     John Garry <john.garry@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sumanesh Samanta <sumanesh.samanta@broadcom.com>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] scsi: avoid to fetch scsi host template instance in IO
 path
Message-ID: <20200302131541.GA13265@lst.de>
References: <20200228093346.31213-1-ming.lei@redhat.com> <f23daab7-7aa0-1c34-8137-7abead09016c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f23daab7-7aa0-1c34-8137-7abead09016c@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Mar 02, 2020 at 10:58:55AM +0000, John Garry wrote:
> On 28/02/2020 09:33, Ming Lei wrote:
>> scsi host template struct is quite big, and the following three
>> fields are needed in SCSI IO path:
>>
>> - queuecommand
>> - commit_rqs
>> - cmd_size
>
> Would it have been nearly as good to reorganise Scsi host template 
> structure to ensure that these are adjacent?
>
> I say nearly, as it avoids the shost->hostt read.

That would be worth trying.  Replicating function pointers out of
read-only data structures generally isn't a very good idea.
