Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7EBF36B55D
	for <lists+linux-scsi@lfdr.de>; Mon, 26 Apr 2021 17:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbhDZPCy (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 26 Apr 2021 11:02:54 -0400
Received: from verein.lst.de ([213.95.11.211]:41667 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232575AbhDZPCy (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 26 Apr 2021 11:02:54 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 711ED68C4E; Mon, 26 Apr 2021 17:02:11 +0200 (CEST)
Date:   Mon, 26 Apr 2021 17:02:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Bart van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 06/39] scsi: introduce scsi_build_sense()
Message-ID: <20210426150211.GG22120@lst.de>
References: <20210423113944.42672-1-hare@suse.de> <20210423113944.42672-7-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423113944.42672-7-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
