Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 806FE2E9719
	for <lists+linux-scsi@lfdr.de>; Mon,  4 Jan 2021 15:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbhADOVa (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 4 Jan 2021 09:21:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:44612 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbhADOVa (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 4 Jan 2021 09:21:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 69132B7A5;
        Mon,  4 Jan 2021 14:20:49 +0000 (UTC)
Date:   Mon, 4 Jan 2021 15:20:49 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     James Smart <jsmart2021@gmail.com>
Cc:     linux-scsi@vger.kernel.org, Ram Vegesna <ram.vegesna@broadcom.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v5 10/31] elx: libefc: FC Domain state machine interfaces
Message-ID: <20210104142049.rnwvd62yykj2oca6@beryllium.lan>
References: <20210103171134.39878-1-jsmart2021@gmail.com>
 <20210103171134.39878-11-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210103171134.39878-11-jsmart2021@gmail.com>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sun, Jan 03, 2021 at 09:11:13AM -0800, James Smart wrote:
> This patch continues the libefc library population.
> 
> This patch adds library interface definitions for:
> - FC Domain registration, allocation and deallocation sequence
> 
> Co-developed-by: Ram Vegesna <ram.vegesna@broadcom.com>
> Signed-off-by: Ram Vegesna <ram.vegesna@broadcom.com>
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Reviewed-by: Daniel Wagner <dwagner@suse.de>
