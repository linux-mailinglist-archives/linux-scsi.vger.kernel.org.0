Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15D8836B5B5
	for <lists+linux-scsi@lfdr.de>; Mon, 26 Apr 2021 17:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbhDZPZ0 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 26 Apr 2021 11:25:26 -0400
Received: from verein.lst.de ([213.95.11.211]:41779 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233573AbhDZPZ0 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 26 Apr 2021 11:25:26 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1008568C4E; Mon, 26 Apr 2021 17:24:43 +0200 (CEST)
Date:   Mon, 26 Apr 2021 17:24:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Bart van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 16/39] scsi: add translate_msg_byte()
Message-ID: <20210426152442.GH25615@lst.de>
References: <20210423113944.42672-1-hare@suse.de> <20210423113944.42672-17-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423113944.42672-17-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

> +static inline void translate_msg_byte(struct scsi_cmnd *cmd, u8 msg)

I think a comment describing the function would be very helpful.
Also maybe scsi_message_to_host_byte might be a more descriptive name?
