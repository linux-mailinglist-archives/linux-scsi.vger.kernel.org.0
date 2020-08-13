Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91F5E24391D
	for <lists+linux-scsi@lfdr.de>; Thu, 13 Aug 2020 13:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgHMLI2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 13 Aug 2020 07:08:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:56846 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbgHMLI1 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 13 Aug 2020 07:08:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EDE65B6A5;
        Thu, 13 Aug 2020 11:08:47 +0000 (UTC)
Date:   Thu, 13 Aug 2020 13:08:25 +0200
From:   David Disseldorp <ddiss@suse.de>
To:     target-devel@vger.kernel.org
Cc:     linux-scsi@vger.kernel.org,
        Mike Christie <michael.christie@oracle.com>
Subject: Re: [RFC PATCH] scsi: target: detect XCOPY NAA descriptor conflicts
Message-ID: <20200813130825.67cf86d0@suse.de>
In-Reply-To: <20200813002142.13820-1-ddiss@suse.de>
References: <20200813002142.13820-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

FWIW, tcmu-runner appears to use the same vpd_unit_serial -> NAA WWN
mapping logic. I'll provide a patch for it too, once we decide on the
best way to address this issue.

Cheers, David
