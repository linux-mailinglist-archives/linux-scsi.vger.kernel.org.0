Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B30B10A2D9
	for <lists+linux-scsi@lfdr.de>; Tue, 26 Nov 2019 17:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbfKZQzy (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 26 Nov 2019 11:55:54 -0500
Received: from verein.lst.de ([213.95.11.211]:41708 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727879AbfKZQzx (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 26 Nov 2019 11:55:53 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2463F68C4E; Tue, 26 Nov 2019 17:55:52 +0100 (CET)
Date:   Tue, 26 Nov 2019 17:55:51 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>
Subject: Re: [PATCH 03/11] dpt_i2o: use scsi_host_flush_commands() to abort
 outstanding commands
Message-ID: <20191126165551.GE8204@lst.de>
References: <20191120103114.24723-1-hare@suse.de> <20191120103114.24723-4-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120103114.24723-4-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Looks good modulo the naming nitpick:

Reviewed-by: Christoph Hellwig <hch@lst.de>
