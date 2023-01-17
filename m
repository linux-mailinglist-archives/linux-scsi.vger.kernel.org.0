Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2FE466E85F
	for <lists+linux-scsi@lfdr.de>; Tue, 17 Jan 2023 22:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjAQVZz (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 17 Jan 2023 16:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjAQVRo (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 17 Jan 2023 16:17:44 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CED49940
        for <linux-scsi@vger.kernel.org>; Tue, 17 Jan 2023 11:39:55 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30HGScqW010515;
        Tue, 17 Jan 2023 19:39:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=DYDoH6vj6w8dZLgdh0Zy1wv3yi5fUsoM11mSU+ToZzg=;
 b=bq503Sb49VxBh5yItRfOTxjMuArH9aAnLLyT/43Cvvz30mcu/4J3qABO56rjcuQgVFWh
 +Yf6dwu2BYH1zUFIjNzDGUiYlJnKwx5IporeFfS98Fj2rZNh5RT8SVP7DxDsRXFMYq4z
 RIapZWeDF7KdNsoIHXMz8HZE2DdLN4wRXtg6IAD23a6KlPw6dzmEN2s00rfIVAGZ8bEa
 tGvS/2Tct28MEQke4yPdGAvniMhQ8cwe3V9rBfAp/BJeaVUOjY3R922dTkt3m/sGkYDk
 le4dD65Fm8g32CiNGy4dT7DD6NEIiaapxBlZsnksVN3YDVymbyICQXCxGjB/wk5yTK73 kA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3m0tnr0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 19:39:45 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30HIYWTe015222;
        Tue, 17 Jan 2023 19:39:44 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n4rq4shf2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 19:39:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYu3OFX+7IJp1aycPG3WP9KdJdClVs0OwRNX6sByTiLzKgpgyXCFPNdIeo2H+yzt2OHwrbUO1MzEm7f31XgOpdDtT1J1woJRjxKH7wdO8lwb6pWWcsoUre9lyjtJsVv5mT+EGwO6cvY3RB0Yd3Nd9olDZA77TMhG9keYEymEcJUQb243MnDFW8AsWsrwv3a826sal2FiylJ8T/2pV4MudMid2mjcroU1bWx4guaq/ZZ0rzV0/bG0NrW9Cwetn+WX56KJ85RR0dJm3aiKG5wv4tqyR8Wma1tlHp4BmljoXdKh13ozNKPib4TpJ3d2LS+G9wh6EQV7QNPdWnbrd75YTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYDoH6vj6w8dZLgdh0Zy1wv3yi5fUsoM11mSU+ToZzg=;
 b=RfDksMKVLF7DrRnM/kKUOeXWPNEmiPClhxn0xa5Ff7Dkq/y30UrJpfJmKJBjMeiswkSsXdIuJ9yqsh6xqm4dNhG9KUqiR7AIexUN5mQGfpYZ/bd9x+pL85gXPQBDHbkZEcYw/5CUEYfn40pk0GB/pymcqufTBXUakiyO8JOEg4tTlbvJjxMoLbmCju/0eJHOdrRh5YM8/WxM5EEejPYBrZ162ofe54qne0+4QppEoHXslYReiSK+O+nr1i3s8LH7h2uOQwhGjEcHZuQ1t3rCtNi6ZYeniKqEyr6r8aUI3ZId4sRYjHq4ISWKsE8abmY4cO9mQE2USy+POgXfRodqmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYDoH6vj6w8dZLgdh0Zy1wv3yi5fUsoM11mSU+ToZzg=;
 b=RiL+TIW5Vat3P1lI0iPXwP8kEiF206oChydyf78hxeew0j6ojexdozYcm+p9xtlA4jy0ujHaarFlVPlt1JVbD2OBg6AWzwgtmmjRun71+wviD+2F8WZCjTmq3KubL6lUDnzzSyY5xLMCtA+bBAShyYJjaPM43K+hd4S5+R+uS7o=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DS0PR10MB7222.namprd10.prod.outlook.com (2603:10b6:8:f2::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.11; Tue, 17 Jan 2023 19:39:42 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::c888:aca:1eb9:ca4f]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::c888:aca:1eb9:ca4f%5]) with mapi id 15.20.6002.011; Tue, 17 Jan 2023
 19:39:42 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     dinghui@sangfor.com.cn, haowenchao22@gmail.com, lduncan@suse.com,
        cleech@redhat.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, jejb@linux.ibm.com
Cc:     Mike Christie <michael.christie@oracle.com>
Subject: [PATCH v2 1/2] scsi: iscsi_tcp: Fix UAF during logout when accessing the shost ipaddress
Date:   Tue, 17 Jan 2023 13:39:36 -0600
Message-Id: <20230117193937.21244-2-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230117193937.21244-1-michael.christie@oracle.com>
References: <20230117193937.21244-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR07CA0100.namprd07.prod.outlook.com
 (2603:10b6:5:337::33) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|DS0PR10MB7222:EE_
X-MS-Office365-Filtering-Correlation-Id: d7910bde-1360-488e-66ef-08daf8c29413
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8iTi0tCcMsgYdQYG5eh5g2i/Dfat0vjWx+bbi14WY05QZD22Kye7SWPEMLkLLOpPm5gcISHs1z6fzpdGp2GW3rovJ19NChspKnTl9waRj7Hcx0bRD+ef0v/lB0bqlB26+e7GKbSBjmCm9a2EPCKQAPyoBeZQuFJF3t++mMRJBmQb1OQpN8xw6Jr3XaB7HP3HcTVPNJO6s2Vhs6WQtz3q8ELImiZj28LUpEuaRRWWfpJ+JG1a+n/WpCrKeW1kWA+KiWG4JRNrH3bpBCu3TFX9VZWln5Fx8f30wwImL9+jKXMSYuAdeXibhmQ1M2uVq2Cd+dY1ALXQqy4LGM2hS+UjraQqA3sIlc1duIiN/5Ez75FSvQD6IqPjyzE9f9E9D8/UciUjDCYaXZ2bm/KsAQ5am3SMLqwdPbu8WsC9DdEeToK2oc7ONvxTKGzvSHi2VNOw7xkSGf0c68C6/ST4nQUbAQ6F5eFr/TlcU1oIznTCbGYNjx6l4mHO6O5wQfCjKPivvzWTR7f+aiY1vqG3QM3IHA7PKPNqW0MkvJ+3C0RvIzeSvp3qG6O6xYBVGuK1RfGnzfN8jV4QpDnnm4b8GaJYi9thaOEnNwG2sufSTfM8CQ3OJ9RygXlW/xTF6B4odKO4ev4FZ6TBZ94RLegjv9wvmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199015)(36756003)(83380400001)(107886003)(6506007)(6666004)(5660300002)(6512007)(186003)(2616005)(2906002)(1076003)(86362001)(26005)(38100700002)(316002)(41300700001)(66946007)(8676002)(66556008)(4326008)(478600001)(8936002)(66476007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o6rZDHsWkm9GOaQlPMITgzXthJSvu6Jx1iG3Smrt+40m3uV0a6hu9wvfF5ng?=
 =?us-ascii?Q?hcNpNocMDpsAU8wNZm1rDEmQty9+7ZvRiDf+QfgXP9hh1ZjOSeA3yx1NQiKx?=
 =?us-ascii?Q?zrxREfmFFy/47kPXTufVF9AOSIgMd6ARpC5gWtGWzK9L4p4f04N9Zcw2UYoH?=
 =?us-ascii?Q?vUNeAVw6NExkPuxIGOr1PzEc8x/T+vsM1zUT77RG3Q2UREPIbNxtSiVPn6yz?=
 =?us-ascii?Q?zdWb/+CnrRpJX51+iM9+LXXOYr1VdR3h6zT854ccNCuhNLfub0BsZfPDxV5e?=
 =?us-ascii?Q?mP+sxjQiEZvJ4PLL10EEY10W+5MgQd4OhJadtWYqIKR6s/HkQBWjDMw549dp?=
 =?us-ascii?Q?3q0iuQLDxm//ADN+7zzHDs2Ybhk5XKF6Go7s8PkS8zmHswjvgRRXA12UcjNU?=
 =?us-ascii?Q?LfQwq/xx63mcdQ22BOtxSYK2f8REbnnWVp5yMo+nxlt2cdRZztANBFXX7iqp?=
 =?us-ascii?Q?UOkg8li55RcqDJNzL1K3HEE0MobNl5Fea2oYCIwLHNdfQxCLaZt0fXpd/Isu?=
 =?us-ascii?Q?zAr4vO+w8YgAPwiI1hWtZEmJ0H9Q7P8IRvRaEKG8gBgqlfDNE14Yr9cyxubw?=
 =?us-ascii?Q?oUFbR0708FemjL5v/xl67W5JlxNJCebPpJ4ytDqmVOp+d6mxqdHFAsDCo7zU?=
 =?us-ascii?Q?NXJv3gPLpNMarRk/Qr+TJ23M1li7HevLJDRMQOIBA4DEQebsygA49cOIBpzk?=
 =?us-ascii?Q?XNXgNZk3IlbYcAyF0hO4qVnyO8hWFo06tlxfAxm5uIdjPAjHI7/cS574VL6h?=
 =?us-ascii?Q?jvUZXB3MPfY2RunHX/YL/U9w0MhRzqaNvYlmAlctW6eKRFcekV4Y6QOVFyvH?=
 =?us-ascii?Q?Co5nE/vW1cBi5WsL7f2/TbGiQgpBw/zGfPRPOAUQbgro2cY25QqwMTuixO4W?=
 =?us-ascii?Q?Tj9d52clMCTJ3ai/FuV3NhV2HwvPB7IAaaVBDd1cnebgphjEoUkPUycBNghy?=
 =?us-ascii?Q?KYr/c8Tk/sYLvMIzLAqF/EtzvfAebEiwdQNpcm48vW8qBxh5C9aFkaeH8d25?=
 =?us-ascii?Q?CVm3mxjU/Nre/aAlE9HO92TZfptr0PT4+u/R1qAfdECMq2oU/SAWFy++ctkW?=
 =?us-ascii?Q?qHSBLRAbyKUWz4ZamjATo2Vt9Tgp+evqF5xZX77/kOZWK1BuyhE8LsPHXDrq?=
 =?us-ascii?Q?YTK5r7ZVUvJwMu9PJ0p/TDn98NVTsZ5Zin7qpWW0yinCercacZHTeTGdkqIK?=
 =?us-ascii?Q?XpW5jefmLB7VOKqatuzG7Pz0QmaDVkBQU44CEQkcvKZWJTCfZjKRmNN0ubwv?=
 =?us-ascii?Q?gtG1030+acYR52yA2GPt1xVYO7Wz8ipItJyYPu2LQ5NSTLCCS0ElExtShIEo?=
 =?us-ascii?Q?ujBofhc/twmvsh4RWaquj4QoYhR/tZ8wwldWl6QEN2B+Pe5S8jA5L4JCi+jk?=
 =?us-ascii?Q?tw9WkXb5r0EAamZMpL64xFtaQ2NrqVo25zt0yj0pxgPfZgio8MMrBegHpI5C?=
 =?us-ascii?Q?CRwhnUMSsGQXPWk2bAQnKQhahroHhJ5Jm+S4mupzuSBoow1GmoFFyG9uGJQP?=
 =?us-ascii?Q?9v4FzJknLccDVXOzQwqRWXofN6a9eyCyrgfEkYffSPI7+68X0s4AupM1x77o?=
 =?us-ascii?Q?vVuoql8GwahVFwmrMjD8wOfCrKmJHtNnUzTRveONgS0engdAqK8wOU2M7slo?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RL6Kn5FxNYwjJEOrUWigC/rciJcEyGopovp0hWenM4Y8v03WfjUYCuVqnZ+Slrx4mkl0jQK2t802qfZSoA37VBpiy+QfpQH0aTSwaujdaE20aMDGZO/3BWupgIYTiRCzya52wYWCeVVwRKaIL02Bhkdt/oz0UsYvNqArWBb4R3v/tpAucGYqSyf/wrp3VFKU7wAqJ7E9PJV1yEX4UkfMEgB2QpsrAzdwQBWlgypi67gCUCtFqxrpVkYqLKFFiOy7bpGSsKvF045FfgHDGdZvpXJxhXt2P0XVmnUXT18EWzDfycUr2mNmQ1Fj9sIFmyeFZPi3wMsJqkBkd+kJ102aDa6QPO22AQXgbbzBjVAvb69UWthodYb/jxSMGljrTyRB6p4dyDLXDVW1yceD00KK3oSDqt0cvKtawRCtTBvDPuRCoBQ01RbpWWo5nwf9HpMNlMXoCMNSYBoIlki7WdEYDLi88YTkl6U1QL5CPX+awZrlxqByMs5sMatLBUoGm6UqqxulWqEf1DuSgyfIgNbj1hgSjW3gDvgUEfkxTWzSTmKNH0bhE6klrVTB3ovwxNwbx2qwsGZaJfQaflam66eU+PCEZG+cgWRsNTcpTLk9MhhtUL3wA5uG0BYaQ+83fBFYn5uQ/eYuyuFl3WM1cMz8VSEBpK7UO2zUqhCjoytmXYoh/eucYzmBFtIUC7TexWBsgjThiKrgcKFyUnYlYnqsSBHslpCvyA5yiwQ03OBbdSnFUNYk0HzFn7gkx7vUsdcWGXoBRhFIL0AwhCYDQ6R0T6DOLgE3jRnVwqKertGkSq2JJ3gmBss9zNxhFaltjL3KEOpyI1QzcpIghCx0JiWOAMxgu9fIdPovXS+KzKMzd7CVBoWn1fWOpWpiS7zjlw5nkM6EwtY7F5icVbWZn4iaK0C5KyYSTUjXbEVicm8UJWQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7910bde-1360-488e-66ef-08daf8c29413
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 19:39:41.9552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iWr3ALyc0+7NPNfm4cYBv8IrvdW24ay2rAkf/omk6jwLea7iF84ysLnyUCD8QXxQvpXhPT9LXJmP2fwLfS+OB7tkGNAaqhdsI3222Sp3jJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7222
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_10,2023-01-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170157
X-Proofpoint-GUID: 8PXZME-Y_2z6sAOMEMOec0z2aYISYZCf
X-Proofpoint-ORIG-GUID: 8PXZME-Y_2z6sAOMEMOec0z2aYISYZCf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Bug report and analysis from Ding Hui.

During iscsi session logout, if another task accesses the shost ipaddress
attr, we can get a KASAN UAF report like this:

[  276.942144] BUG: KASAN: use-after-free in _raw_spin_lock_bh+0x78/0xe0
[  276.942535] Write of size 4 at addr ffff8881053b45b8 by task cat/4088
[  276.943511] CPU: 2 PID: 4088 Comm: cat Tainted: G            E      6.1.0-rc8+ #3
[  276.943997] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
[  276.944470] Call Trace:
[  276.944943]  <TASK>
[  276.945397]  dump_stack_lvl+0x34/0x48
[  276.945887]  print_address_description.constprop.0+0x86/0x1e7
[  276.946421]  print_report+0x36/0x4f
[  276.947358]  kasan_report+0xad/0x130
[  276.948234]  kasan_check_range+0x35/0x1c0
[  276.948674]  _raw_spin_lock_bh+0x78/0xe0
[  276.949989]  iscsi_sw_tcp_host_get_param+0xad/0x2e0 [iscsi_tcp]
[  276.951765]  show_host_param_ISCSI_HOST_PARAM_IPADDRESS+0xe9/0x130 [scsi_transport_iscsi]
[  276.952185]  dev_attr_show+0x3f/0x80
[  276.953005]  sysfs_kf_seq_show+0x1fb/0x3e0
[  276.953401]  seq_read_iter+0x402/0x1020
[  276.954260]  vfs_read+0x532/0x7b0
[  276.955113]  ksys_read+0xed/0x1c0
[  276.955952]  do_syscall_64+0x38/0x90
[  276.956347]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  276.956769] RIP: 0033:0x7f5d3a679222
[  276.957161] Code: c0 e9 b2 fe ff ff 50 48 8d 3d 32 c0 0b 00 e8 a5 fe 01 00 0f 1f 44 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 0f 05 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 48 83 ec 28 48 89 54 24
[  276.958009] RSP: 002b:00007ffc864d16a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[  276.958431] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007f5d3a679222
[  276.958857] RDX: 0000000000020000 RSI: 00007f5d3a4fe000 RDI: 0000000000000003
[  276.959281] RBP: 00007f5d3a4fe000 R08: 00000000ffffffff R09: 0000000000000000
[  276.959682] R10: 0000000000000022 R11: 0000000000000246 R12: 0000000000020000
[  276.960126] R13: 0000000000000003 R14: 0000000000000000 R15: 0000557a26dada58
[  276.960536]  </TASK>
[  276.961357] Allocated by task 2209:
[  276.961756]  kasan_save_stack+0x1e/0x40
[  276.962170]  kasan_set_track+0x21/0x30
[  276.962557]  __kasan_kmalloc+0x7e/0x90
[  276.962923]  __kmalloc+0x5b/0x140
[  276.963308]  iscsi_alloc_session+0x28/0x840 [scsi_transport_iscsi]
[  276.963712]  iscsi_session_setup+0xda/0xba0 [libiscsi]
[  276.964078]  iscsi_sw_tcp_session_create+0x1fd/0x330 [iscsi_tcp]
[  276.964431]  iscsi_if_create_session.isra.0+0x50/0x260 [scsi_transport_iscsi]
[  276.964793]  iscsi_if_recv_msg+0xc5a/0x2660 [scsi_transport_iscsi]
[  276.965153]  iscsi_if_rx+0x198/0x4b0 [scsi_transport_iscsi]
[  276.965546]  netlink_unicast+0x4d5/0x7b0
[  276.965905]  netlink_sendmsg+0x78d/0xc30
[  276.966236]  sock_sendmsg+0xe5/0x120
[  276.966576]  ____sys_sendmsg+0x5fe/0x860
[  276.966923]  ___sys_sendmsg+0xe0/0x170
[  276.967300]  __sys_sendmsg+0xc8/0x170
[  276.967666]  do_syscall_64+0x38/0x90
[  276.968028]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  276.968773] Freed by task 2209:
[  276.969111]  kasan_save_stack+0x1e/0x40
[  276.969449]  kasan_set_track+0x21/0x30
[  276.969789]  kasan_save_free_info+0x2a/0x50
[  276.970146]  __kasan_slab_free+0x106/0x190
[  276.970470]  __kmem_cache_free+0x133/0x270
[  276.970816]  device_release+0x98/0x210
[  276.971145]  kobject_cleanup+0x101/0x360
[  276.971462]  iscsi_session_teardown+0x3fb/0x530 [libiscsi]
[  276.971775]  iscsi_sw_tcp_session_destroy+0xd8/0x130 [iscsi_tcp]
[  276.972143]  iscsi_if_recv_msg+0x1bf1/0x2660 [scsi_transport_iscsi]
[  276.972485]  iscsi_if_rx+0x198/0x4b0 [scsi_transport_iscsi]
[  276.972808]  netlink_unicast+0x4d5/0x7b0
[  276.973201]  netlink_sendmsg+0x78d/0xc30
[  276.973544]  sock_sendmsg+0xe5/0x120
[  276.973864]  ____sys_sendmsg+0x5fe/0x860
[  276.974248]  ___sys_sendmsg+0xe0/0x170
[  276.974583]  __sys_sendmsg+0xc8/0x170
[  276.974891]  do_syscall_64+0x38/0x90
[  276.975216]  entry_SYSCALL_64_after_hwframe+0x63/0xcd

We can easily reproduce by two tasks:
1. while :; do iscsiadm -m node --login; iscsiadm -m node --logout; done
2. while :; do cat \
/sys/devices/platform/host*/iscsi_host/host*/ipaddress; done

            iscsid              |        cat
--------------------------------+---------------------------------------
|- iscsi_sw_tcp_session_destroy |
  |- iscsi_session_teardown     |
    |- device_release           |
      |- iscsi_session_release  ||- dev_attr_show
        |- kfree                |  |- show_host_param_
                                |             ISCSI_HOST_PARAM_IPADDRESS
                                |    |- iscsi_sw_tcp_host_get_param
                                |      |- r/w tcp_sw_host->session (UAF)
  |- iscsi_host_remove          |
  |- iscsi_host_free            |

This patch fixes the above bug by splitting the session removal into 2
parts:
1. removal from iSCSI class which includes sysfs and removal from host
tracking.
2. freeing of session.

During iscsi_tcp host and session removal we can remove the session from
sysfs then remove the host from sysfs. At this point we know userspace is
not accessing the kernel via sysfs so we can free the session and host.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/scsi/iscsi_tcp.c | 11 +++++++++--
 drivers/scsi/libiscsi.c  | 38 +++++++++++++++++++++++++++++++-------
 include/scsi/libiscsi.h  |  2 ++
 3 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
index 5fb1f364e815..9c0c8f34ef67 100644
--- a/drivers/scsi/iscsi_tcp.c
+++ b/drivers/scsi/iscsi_tcp.c
@@ -982,10 +982,17 @@ static void iscsi_sw_tcp_session_destroy(struct iscsi_cls_session *cls_session)
 	if (WARN_ON_ONCE(session->leadconn))
 		return;
 
+	iscsi_session_remove(cls_session);
+	/*
+	 * Our get_host_param needs to access the session, so remove the
+	 * host from sysfs before freeing the session to make sure userspace
+	 * is no longer accessing the callout.
+	 */
+	iscsi_host_remove(shost, false);
+
 	iscsi_tcp_r2tpool_free(cls_session->dd_data);
-	iscsi_session_teardown(cls_session);
 
-	iscsi_host_remove(shost, false);
+	iscsi_session_free(cls_session);
 	iscsi_host_free(shost);
 }
 
diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
index d95f4bcdeb2e..6e811d753cb1 100644
--- a/drivers/scsi/libiscsi.c
+++ b/drivers/scsi/libiscsi.c
@@ -3104,17 +3104,32 @@ iscsi_session_setup(struct iscsi_transport *iscsit, struct Scsi_Host *shost,
 }
 EXPORT_SYMBOL_GPL(iscsi_session_setup);
 
-/**
- * iscsi_session_teardown - destroy session, host, and cls_session
- * @cls_session: iscsi session
+/*
+ * issi_session_remove - Remove session from iSCSI class.
  */
-void iscsi_session_teardown(struct iscsi_cls_session *cls_session)
+void iscsi_session_remove(struct iscsi_cls_session *cls_session)
 {
 	struct iscsi_session *session = cls_session->dd_data;
-	struct module *owner = cls_session->transport->owner;
 	struct Scsi_Host *shost = session->host;
 
 	iscsi_remove_session(cls_session);
+	/*
+	 * host removal only has to wait for its children to be removed from
+	 * sysfs, and iscsi_tcp needs to do iscsi_host_remove before freeing
+	 * the session, so drop the session count here.
+	 */
+	iscsi_host_dec_session_cnt(shost);
+}
+EXPORT_SYMBOL_GPL(iscsi_session_remove);
+
+/**
+ * iscsi_session_free - Free iscsi session and it's resources
+ * @cls_session: iscsi session
+ */
+void iscsi_session_free(struct iscsi_cls_session *cls_session)
+{
+	struct iscsi_session *session = cls_session->dd_data;
+	struct module *owner = cls_session->transport->owner;
 
 	iscsi_pool_free(&session->cmdpool);
 	kfree(session->password);
@@ -3132,10 +3147,19 @@ void iscsi_session_teardown(struct iscsi_cls_session *cls_session)
 	kfree(session->discovery_parent_type);
 
 	iscsi_free_session(cls_session);
-
-	iscsi_host_dec_session_cnt(shost);
 	module_put(owner);
 }
+EXPORT_SYMBOL_GPL(iscsi_session_free);
+
+/**
+ * iscsi_session_teardown - destroy session and cls_session
+ * @cls_session: iscsi session
+ */
+void iscsi_session_teardown(struct iscsi_cls_session *cls_session)
+{
+	iscsi_session_remove(cls_session);
+	iscsi_session_free(cls_session);
+}
 EXPORT_SYMBOL_GPL(iscsi_session_teardown);
 
 /**
diff --git a/include/scsi/libiscsi.h b/include/scsi/libiscsi.h
index 654cc3918c94..7523b6abd8e2 100644
--- a/include/scsi/libiscsi.h
+++ b/include/scsi/libiscsi.h
@@ -422,6 +422,8 @@ extern int iscsi_host_get_max_scsi_cmds(struct Scsi_Host *shost,
 extern struct iscsi_cls_session *
 iscsi_session_setup(struct iscsi_transport *, struct Scsi_Host *shost,
 		    uint16_t, int, int, uint32_t, unsigned int);
+void iscsi_session_remove(struct iscsi_cls_session *cls_session);
+void iscsi_session_free(struct iscsi_cls_session *cls_session);
 extern void iscsi_session_teardown(struct iscsi_cls_session *);
 extern void iscsi_session_recovery_timedout(struct iscsi_cls_session *);
 extern int iscsi_set_param(struct iscsi_cls_conn *cls_conn,
-- 
2.25.1

