Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 926D14023B1
	for <lists+linux-scsi@lfdr.de>; Tue,  7 Sep 2021 08:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbhIGGzt (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 7 Sep 2021 02:55:49 -0400
Received: from verein.lst.de ([213.95.11.211]:34797 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234472AbhIGGzr (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 7 Sep 2021 02:55:47 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5CB5867373; Tue,  7 Sep 2021 08:54:39 +0200 (CEST)
Date:   Tue, 7 Sep 2021 08:54:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Laibin Qiu <qiulaibin@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, hare@suse.de,
        linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH -next] [SCSI] Fix NULL pointer dereference in handling
 for passthrough commands
Message-ID: <20210907065438.GA29528@lst.de>
References: <20210904064534.1919476-1-qiulaibin@huawei.com> <1b056b0b-fd96-03db-b19a-8bff6c40f8f0@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b056b0b-fd96-03db-b19a-8bff6c40f8f0@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Sep 06, 2021 at 05:40:35PM -0700, Bart Van Assche wrote:
> On 9/3/21 23:45, Laibin Qiu wrote:
>>   	cmd->cmd_len = scsi_req(req)->cmd_len;
>> +	cmd->cmnd = scsi_req(req)->cmd;
>>   	if (cmd->cmd_len == 0)
>>   		cmd->cmd_len = scsi_command_size(cmd->cmnd);
>> -	cmd->cmnd = scsi_req(req)->cmd;
>>   	cmd->transfersize = blk_rq_bytes(req);
>
> Thinking further about this: is there any code left that depends on 
> scsi_setup_scsi_cmnd() setting cmd->cmd_len? Can the cmd->cmd_len 
> assignment be removed from scsi_setup_scsi_cmnd()?

cmd_len should never be 0 now, so I think we can remove it.
