Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 158322ED62B
	for <lists+linux-scsi@lfdr.de>; Thu,  7 Jan 2021 18:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbhAGR6Z (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 7 Jan 2021 12:58:25 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:41928 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728131AbhAGR6Y (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 7 Jan 2021 12:58:24 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 107HsoL3089446;
        Thu, 7 Jan 2021 17:57:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=u9DEn27WHLjLH+RPDAtJ0DDpHFMigkQ/vF201ccKZls=;
 b=xC1UGJa+8nbvLCMAggec2iGv+sr8fUFH4EQwoIuvmnbx3W9hF0QEZ1+KgScymGGBK/3G
 1qMPS9giNkwel29eJch5cHaHkojKfQ+1qHEI9YDCAb416cp2Uy5YrC0ah/Hyb/wJ/MHg
 o9/2QiRharIdeQjK9Vok9d562hV8UpkERA5xy0XuhrcR5iKZzfWAHePRQZtLUZL4JciD
 6HDVnbp8ksh94bD2H1uLH1GYlN2i9FNYRzTrKYK3cpcYkVp3/yeWM1hoBNOn5bvl45DN
 bucLzudEuL5pq/vxXJTbHupTwrrSfRha47mwCxF/r5bU70Z2f9cLkUpN7aqNwci94q7a bQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 35wcuxwy6d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 07 Jan 2021 17:57:42 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 107Hsxrx096610;
        Thu, 7 Jan 2021 17:57:42 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 35v1fbhpmf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jan 2021 17:57:42 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 107HvfnF011863;
        Thu, 7 Jan 2021 17:57:41 GMT
Received: from [192.168.63.242] (/71.42.68.90)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 Jan 2021 09:57:28 -0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [EXT] [PATCH v3 1/7] qla2xxx: Implementation to get and manage
 host, target stats and initiator port
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
In-Reply-To: <BN8PR18MB30257A867FEEE66D619C12C3D2AF9@BN8PR18MB3025.namprd18.prod.outlook.com>
Date:   Thu, 7 Jan 2021 11:57:28 -0600
Cc:     Nilesh Javali <njavali@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        GR-QLogic-Storage-Upstream <GR-QLogic-Storage-Upstream@marvell.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <89A792AF-49D2-425A-AC0E-BA673C84A181@oracle.com>
References: <20210105103847.25041-1-njavali@marvell.com>
 <20210105103847.25041-2-njavali@marvell.com>
 <DC6A6732-5FF5-48BA-AAEA-75DAD94F1A55@oracle.com>
 <BN8PR18MB30257A867FEEE66D619C12C3D2AF9@BN8PR18MB3025.namprd18.prod.outlook.com>
To:     Saurav Kashyap <skashyap@marvell.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9857 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101070105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9857 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101070105
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



> On Jan 6, 2021, at 11:34 PM, Saurav Kashyap <skashyap@marvell.com> =
wrote:
>=20
> <SK> It's a state of the port, it comes as part of managing the port. =
If the error count is more,
> user can opt to change the state and port will go to offline state.

In that case, small description in a commit message would have been very =
helpful. Its not Clear from the patch about user=E2=80=99s capability of =
changing state of port=20

--
Himanshu Madhani	 Oracle Linux Engineering

