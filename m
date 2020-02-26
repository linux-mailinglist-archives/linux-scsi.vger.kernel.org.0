Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A355E170649
	for <lists+linux-scsi@lfdr.de>; Wed, 26 Feb 2020 18:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgBZRjy (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 26 Feb 2020 12:39:54 -0500
Received: from verein.lst.de ([213.95.11.211]:50016 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726747AbgBZRjy (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 26 Feb 2020 12:39:54 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 55A0768CEE; Wed, 26 Feb 2020 18:39:52 +0100 (CET)
Date:   Wed, 26 Feb 2020 18:39:52 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 02/13] scsi: add scsi_host_complete_all_commands()
 helper
Message-ID: <20200226173952.GA23141@lst.de>
References: <20200213140422.128382-1-hare@suse.de> <20200213140422.128382-3-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213140422.128382-3-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, Feb 13, 2020 at 03:04:11PM +0100, Hannes Reinecke wrote:
>  extern void scsi_host_put(struct Scsi_Host *t);
>  extern struct Scsi_Host *scsi_host_lookup(unsigned short);
>  extern const char *scsi_host_state_name(enum scsi_host_state);
> +extern void scsi_host_complete_all_commands(struct Scsi_Host *shost, int status);

This adds an > 80 char line.  And externs on function declarations in
headers are never needed anyway.
