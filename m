Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB3D728BE1F
	for <lists+linux-scsi@lfdr.de>; Mon, 12 Oct 2020 18:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403796AbgJLQhZ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 12 Oct 2020 12:37:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:45126 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726742AbgJLQhZ (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 12 Oct 2020 12:37:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 85F20AC97;
        Mon, 12 Oct 2020 16:37:24 +0000 (UTC)
Date:   Mon, 12 Oct 2020 18:37:24 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Arun Easi <aeasi@marvell.com>
Cc:     Nilesh Javali <njavali@marvell.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] qla2xxx: Return EBUSY on fcport deletion
Message-ID: <20201012163724.jozj3t3kjxty2pb2@beryllium.lan>
References: <20201012091100.55305-1-dwagner@suse.de>
 <alpine.LRH.2.21.9999.2010120904230.28578@irv1user01.caveonetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.9999.2010120904230.28578@irv1user01.caveonetworks.com>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Oct 12, 2020 at 09:07:15AM -0700, Arun Easi wrote:
> This does not appear to be cut against the latest for-next/staging; "rval" 
> is not used there for the initial set of returns.

Indeed, forgot to use staging. It's against queue. Let me update it.

> Anyway, returning EBUSY is the right way to go.

Thanks for the confirmation.

Daniel
