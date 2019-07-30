Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 998F07AD7A
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Jul 2019 18:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfG3QZD (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 30 Jul 2019 12:25:03 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53902 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfG3QZD (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 30 Jul 2019 12:25:03 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6UGNUc4021439;
        Tue, 30 Jul 2019 16:24:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=TGv4YSWswRKFCDZ7rg/IxdWVdb4awoeVkilaTJMnVfo=;
 b=b+LzWRPkJlqDrvsLwXU323bT519eCQVPd3kgsC+NRsjefVauxTMgC5pU0e0FGTMHucHN
 zE90yf0MefL1B4XvpRVETG47CDuo0eEcH/7lUeFGCO5EF2f0ilo5AQYaLn/rnEJkhrnZ
 2Ay/hVR15ov6AG2LCSNoSCIXwU6ZbmIpddM093IXmvS3Y9xRGg7LMCGtCwWXvn4NpwZP
 mLNyrNn0rHoHziLvTM/1lMJiqy61DDJywNJwtt/DHEhtxA5v2+lrelhuTaEGc7b6LJvj
 96K6Ttd7eivzUeOMOq6VD6r/Z+85u2wWCdn6/1xht3wK40Egr9YlN38nt1McgKmEXHPx mw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2u0f8qyk76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 16:24:53 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6UGMSJ5079719;
        Tue, 30 Jul 2019 16:24:53 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2u0xv89tg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 16:24:52 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6UGOlTC002146;
        Tue, 30 Jul 2019 16:24:51 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Jul 2019 09:24:47 -0700
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCHv3 0/3] fcoe: cleanup fc_rport_priv usage
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190724090056.7506-1-hare@suse.de>
Date:   Tue, 30 Jul 2019 12:24:45 -0400
In-Reply-To: <20190724090056.7506-1-hare@suse.de> (Hannes Reinecke's message
        of "Wed, 24 Jul 2019 11:00:53 +0200")
Message-ID: <yq1v9vjmqwi.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9334 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=958
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907300170
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9334 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907300170
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Hannes,

> the fcoe vn2vn code is using the 'fc_rport_priv' structure as argument
> to its internal function, but is really expecting a struct fcoe_rport
> to immediately follow this one. This is not only confusing but also an
> error for new compilers.  So clean up the usage by embedding
> fc_rport_priv into fcoe_rport, and use the fcoe_rport structure
> wherever possible.  This patchset also contains some minor whitespace
> cleanups for libfc.h.

Applied to 5.3/scsi-fixes. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
