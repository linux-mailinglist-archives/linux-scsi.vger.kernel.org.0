Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A54299978
	for <lists+linux-scsi@lfdr.de>; Mon, 26 Oct 2020 23:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392780AbgJZWSI (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 26 Oct 2020 18:18:08 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:43486 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392725AbgJZWSI (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 26 Oct 2020 18:18:08 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09QMFdNg062108;
        Mon, 26 Oct 2020 22:17:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=JBHC3Tv9jAUAHUjVj7llOjchS0J/AGl03MlghuwQQaE=;
 b=HStaSDxTpzgb0Cc0CwVDhnfoTRhJmadyKep1fyH9tXZ+SxsTB5t4ETIzuKwS3cHK/E7/
 JmCYqOtwAxdBNVjxro+Qq2tHjMg0QaFrsNFJNk6r9VbfQv8xSBqkK+Y7sfEaX+BVM2uy
 gwA4+peCsTQkp9qqKl83nP/s+XZSv2aPc5F91p/ViI5FLbo4tjy2ZhqdUrtoXmZ8hjuZ
 v9cJ8WH9JTGievC2RSDgrvTiE4sKBmy2TGNEhfgRN+bz0AMzxvVWU3A694F0SU5T6gPe
 XxmmvOhNxipY61ucDon1RbYlA7Mwx65c7c5GUCFIiIHYkoBWR+Le2onYg4dkrP8/ViPK qQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 34c9saq6kg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Oct 2020 22:17:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09QMGEhr058299;
        Mon, 26 Oct 2020 22:17:56 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 34cx1q0r70-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Oct 2020 22:17:56 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09QMHro7032276;
        Mon, 26 Oct 2020 22:17:53 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 26 Oct 2020 15:17:52 -0700
To:     Tyrel Datwyler <tyreld@linux.ibm.com>
Cc:     james.bottomley@hansenpartnership.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brking@linux.ibm.com
Subject: Re: [PATCH] ibmvscsi: fix race potential race after loss of transport
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1v9ew7hve.fsf@ca-mkp.ca.oracle.com>
References: <20201025001355.4527-1-tyreld@linux.ibm.com>
Date:   Mon, 26 Oct 2020 18:17:50 -0400
In-Reply-To: <20201025001355.4527-1-tyreld@linux.ibm.com> (Tyrel Datwyler's
        message of "Sat, 24 Oct 2020 19:13:55 -0500")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9786 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=1 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010260144
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9786 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1011 suspectscore=1
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010260144
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Tyrel,

> After a loss of tranport due to an adatper migration or
> crash/disconnect from the host partner there is a tiny window where we
> can race adjusting the request_limit of the adapter.

Applied to 5.10/scsi-fixes, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
