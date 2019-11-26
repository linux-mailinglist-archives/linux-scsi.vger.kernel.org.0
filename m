Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 464A010A2D7
	for <lists+linux-scsi@lfdr.de>; Tue, 26 Nov 2019 17:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbfKZQzg (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 26 Nov 2019 11:55:36 -0500
Received: from verein.lst.de ([213.95.11.211]:41703 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728593AbfKZQzf (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 26 Nov 2019 11:55:35 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 346BB68C4E; Tue, 26 Nov 2019 17:55:34 +0100 (CET)
Date:   Tue, 26 Nov 2019 17:55:33 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 02/11] scsi: add scsi_host_flush_commands() helper
Message-ID: <20191126165533.GD8204@lst.de>
References: <20191120103114.24723-1-hare@suse.de> <20191120103114.24723-3-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191120103114.24723-3-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

flush is such a heavіly overloaded term.  What about
scsi_host_complete_all_commands?
